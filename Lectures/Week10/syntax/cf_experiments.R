# Try this stuff at top
library(dplyr)
library(modelr)
library(tidyr)

cf_data<- data_grid(any_arrest_data, white_comp_wit_vict, black_arr_susp,
                     crime_type, neighb_type, .model=mod_arrest) %>%
  mutate(caller_type = factor("Complainant", 
                              levels=c("Victim", "Witness", "Complainant")),
         year        = factor("2010", 
                              levels = as.character(2008:2012))) %>%
  model_matrix(formula(delete.response(terms(mod_arrest))))


# -- for predict!
cf_pred <- predict(mod_arrest, newdata = data_grid(any_arrest_data, white_comp_wit_vict, black_arr_susp,
                                        crime_type, neighb_type, .model=mod_arrest) %>%
          mutate(caller_type = factor("Complainant", 
                                      levels=c("Victim", "Witness", "Complainant")),
                 year        = factor("2010", 
                                      levels = as.character(2008:2012))), type = "response", se.fit=T)

estimated_pes_2 <- cf_data %>% select(Reporter, Target, `Crime Type`, Neighborhood)

#--
# Old below, could probably augment with above

model_matrix(any_arrest_data, formula(mod_arrest))

modelr::data_grid(mtcars, wt=modelr::seq_range(wt, 10), cyl, vs)

load("./Lectures/Week11/data/any_arrest_data.RData")

mod_arrest <- glm(arrest ~ white_comp_wit_vict*black_arr_susp + 
                    crime_type*white_comp_wit_vict + caller_type + 
                    arr_susp_subj_count + comp_wit_vict_count +
                    black_arr_susp*neighb_type + crime_type*neighb_type + 
                    serious_rate + pbl + pot + dis + year,
                  family = binomial(link = "logit"),
                  data = any_arrest_data)




mod_arrest_pred <- predict(mod_arrest, newdata=cf_data, se.fit=TRUE)
mod_arrest_pred_df <- data.frame(pe=mod_arrest_pred$fit, 
           lb=mod_arrest_pred$fit-mod_arrest_pred$se.fit, 
           ub=mod_arrest_pred$fit+mod_arrest_pred$se.fit)
cf_data <- cbind(cf_data, exp(mod_arrest_pred_df)/(1+exp(mod_arrest_pred_df)))

ggplot(cf_data, aes(x = forcats::as_factor(black_arr_susp), y = pe, group = white_comp_wit_vict)) + 
  facet_grid(forcats::fct_relevel(crime_type, "Nuisance") ~ forcats::fct_relevel(neighb_type, "Changing", "BlackDisadv", "StableWhite")) +
  geom_errorbar(aes(ymin = lb, ymax = ub), 
                position = position_dodge(width = .4), 
                size = 0.75, width = 0.15) +
  geom_point(shape = 21, aes(fill = white_comp_wit_vict),
             position = position_dodge(width = .4), 
             size = 2) + 
  scale_fill_manual("Reporter", values=c("1" = "white", 
                                         "0" = "black")) +
  scale_x_discrete("Target", labels=c("White", 
                                         "Black")) +
  ggtitle("Figure 3. Probability of Arrest", 
          subtitle = "by Reporter and Target Race, Neighborhood and Crime Type") +
  xlab("Race of Target") + ylab("Estimated Probability") + 
  theme_bw() + theme(legend.position = c(0.86,0.15),
                     legend.background = element_rect(color = 1))

#-------

sim_params <- MASS::mvrnorm(n = 10000, 
                            mu = coef(mod_arrest),
                            Sigma = vcov(mod_arrest))
sim_params[1:6, 1:4]

x_values <- colMeans(model.matrix(mod_arrest)) # vars at mean
n_scen   <- (2*2*2*3) # Number of scenarios
x_frame  <- setNames(data.frame(matrix(x_values, nrow=n_scen, 
                                       ncol=length(x_values), 
                                       byrow=T)), names(x_values))
cf_vals  <- arrangements::permutations(c(0,1), k=5, replace=T) #<<
cf_vals  <- cf_vals[cf_vals[,4]+cf_vals[,5]!=2 ,] # Remove impossible vals
colnames(cf_vals) <- c("white_comp_wit_vict1", "black_arr_susp1", 
                       "crime_typeNuisance", "neighb_typeBlackDisadv",
                       "neighb_typeChanging")
x_frame[colnames(cf_vals)] <- cf_vals # assign to countefactual df

glimpse(x_frame)

x_frame <- x_frame %>%
 mutate(
  `white_comp_wit_vict1:black_arr_susp1`      = white_comp_wit_vict1*black_arr_susp1,
  `white_comp_wit_vict1:crime_typeNuisance`   = white_comp_wit_vict1*crime_typeNuisance,
  `black_arr_susp1:neighb_typeBlackDisadv`    = black_arr_susp1*neighb_typeBlackDisadv,
  `black_arr_susp1:neighb_typeChanging`       = black_arr_susp1*neighb_typeChanging,
  `crime_typeNuisance:neighb_typeBlackDisadv` = crime_typeNuisance*neighb_typeBlackDisadv,
  `crime_typeNuisance:neighb_typeChanging`    = crime_typeNuisance*neighb_typeChanging,
  `black_arr_susp1:neighb_typeBlackDisadv`    = black_arr_susp1*neighb_typeBlackDisadv,
  `black_arr_susp1:neighb_typeChanging`       = black_arr_susp1*neighb_typeChanging)

glimpse(x_frame)

sims_logodds <- sim_params %*% t(as.matrix(x_frame))  
sims_logodds[1:6, 1:6]
dim(sims_logodds)

sims_prob    <- exp(sims_logodds) / (1 + exp(sims_logodds))
sims_prob[1:6, 1:6]

extract_pe_ci <- function(x){
  vals <- c(mean(x), quantile(x, probs=c(.025, .975)))
  names(vals) <- c("PE", "LB", "UB")
  return(vals)
}
estimated_pes <- as.data.frame( t(apply(sims_prob, 2, extract_pe_ci)))

    estimated_pes$`Reporter`     <- ifelse(cf_vals[,1]==1, "Any White", "All Black")
  estimated_pes$`Target`       <- ifelse(cf_vals[,2]==1, "Any Black", "All White")
  estimated_pes$`Crime Type`   <- ifelse(cf_vals[,3]==1, "Nuisance Crime", "Serious Crime")
  estimated_pes$`Neighborhood` <- case_when(
    cf_vals[,4]==1 ~ "Disadvantaged",
    cf_vals[,5]==1 ~ "Changing",
    TRUE ~ "Stable White")

estimated_pes %>% mutate_if(is.numeric, round, digits=3) # round for display

ggplot(estimated_pes, aes(x = Target, y = PE, group = Reporter)) + 
  facet_grid(`Crime Type` ~ Neighborhood) +
  geom_errorbar(aes(ymin = LB, ymax = UB), 
                position = position_dodge(width = .4), 
                size = 0.75, width = 0.15) +
  geom_point(shape = 21, aes(fill = Reporter),
             position = position_dodge(width = .4), 
             size = 2) + 
  scale_fill_manual("Reporter", values=c("Any White" = "white", 
                                         "All Black" = "black")) +
  ggtitle("Figure 3. Probability of Arrest", 
          subtitle = "by Reporter and Target Race, Neighborhood and Crime Type") +
  xlab("Race of Target") + ylab("Estimated Probability") + 
  theme_bw() + theme(legend.position = c(0.86,0.15),
                     legend.background = element_rect(color = 1))
