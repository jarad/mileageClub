#' Get mileage club summary
#' 
#' Get the mileage club summary as a shiny app which reports the miles run each week,
#' the cumulative miles run, and some other information.
#' 
#' @export
#' @examples
#' \dontrun{
#' summary()
#' }
summary = function() {
  appDir = system.file("shiny-examples","mileageClub", package="mileageClub")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mileageClub`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal", launch.browser = TRUE)
}
