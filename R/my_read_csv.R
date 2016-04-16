#' Read csv file and extract date column from filename
#' 
#' Read csv file whose filename is the date in YYYYMMDD format and 
#' add this date as a column in the returned data.frame.
#' 
#' @param f A YYYYMMDD.csv file
#' @return A \code{data.frame} containing the information from the csv file as well as a date column from the filename itself.
#' @examples 
#' \dontrun{
#' my_read_csv('20160416.csv')
#' }
my_read_csv = function(f) {
  d = readr::read_csv(f)
  d$date = as.Date(stringr::str_extract(f, '[0-9]{8}'), format="%Y%m%d")
  return(d)
}
