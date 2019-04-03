render_and_print_slides <- function(week){
  if (Sys.info()["user"]=="cclan"){
    week_dir     <- paste0(getwd(), "/Lectures/", "Week", week, "/")
    current_rmd  <- paste0(week_dir, stringr::str_subset(list.files(week_dir), "^CSSS508_Week.*\\.Rmd$"))
    rmarkdown::render(current_rmd, encoding = "UTF-8")
    current_html <- stringr::str_replace(current_rmd, "\\.Rmd", "\\.html")
    new_file     <- stringr::str_replace(current_html, "\\.html", "\\.pdf")
    Sys.sleep(5)
    system_call  <- paste0('"C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe" --headless --print-to-pdf=', 
                           new_file, 
                           " ", 
                           current_html)
    system(system_call)
  } else {
    warning("Script not portable, modify for your machine.")
  }
}
