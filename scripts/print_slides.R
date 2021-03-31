# This script automates rendering of slides, purling of the R code into a .R
# script, and generation of PDFs using a headless Chrome instance via Pagedown.

render_and_print_slides <- function(week){
    week_dir     <- paste0(getwd(), "/Lectures/", "Week", week, "/") # Construct an absolute path based on project dir
    current_rmd  <- paste0(week_dir, stringr::str_subset(list.files(week_dir),
                                                     "^CSSS508_Week.*\\.Rmd$")) # Get path of current Rmd
    rmarkdown::render(current_rmd, encoding = "UTF-8") # Render current RMD
    # Next, create some file names for input and output
    current_html <- stringr::str_replace(current_rmd,  "\\.Rmd",  "\\.html")
    new_pdf_file <- stringr::str_replace(current_html, "\\.html", "\\.pdf")
    new_r_script <- stringr::str_replace(current_html, "\\.html", "\\.R")
    message("Slides rendered, waiting 5 seconds.") 
    Sys.sleep(5) # Give a delay to finish writing file
    message("Purling slides.")
    # Purling ripes the R code out of an .Rmd to make a R script
    knitr::purl(input = current_rmd, output = new_r_script, documentation = 0)
    message("Printing from Chrome.")
    # Pagedown's chrom_print() renders PDFs nicely from HTML
    pagedown::chrome_print(current_html, format="pdf")
    message(paste0("Printing complete at ", week_dir))
}

# This function runs a loop to just iterates over multiple lectures--all by default
build_course <- function(lectures = 1:10){
    for(i in lectures){
        render_and_print_slides(i)
    }
}
