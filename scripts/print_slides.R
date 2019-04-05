render_and_print_slides <- function(week){
    week_dir     <- paste0(getwd(), "/Lectures/", "Week", week, "/")
    current_rmd  <- paste0(week_dir, stringr::str_subset(list.files(week_dir),
                                                     "^CSSS508_Week.*\\.Rmd$"))
    rmarkdown::render(current_rmd, encoding = "UTF-8")
    current_html <- stringr::str_replace(current_rmd,  "\\.Rmd",  "\\.html")
    new_file     <- stringr::str_replace(current_html, "\\.html", "\\.pdf")
    message("Slides rendered, waiting 5 seconds.")
    Sys.sleep(5)
    message("Printing from Chrome.")
    pagedown::chrome_print(current_html, format="pdf")
    message(paste0("Printing complete at ", week_dir))
}
