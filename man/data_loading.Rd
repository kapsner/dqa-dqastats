% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataloading.R
\name{data_loading}
\alias{data_loading}
\title{data_loading helper function}
\usage{
data_loading(rv, system, keys_to_test)
}
\arguments{
\item{rv}{The complete reactive-value dataset}

\item{system}{The part of the rv-list which should be loaded
(e.g. rv$source or rv$target)}

\item{keys_to_test}{A vector containing the names (keys) of
the variables to test.}
}
\value{
A list with the fields '$outdata' and if testing an SQL-based
  database also '$sql_statements'.
}
\description{
Internal function to load the source and target data
}
\examples{
utils_path <- system.file(
  "demo_data/utilities/",
  package = "DQAstats"
)
mdr_filename <- "mdr_example_data.csv"
rv <- list()
rv$mdr <- read_mdr(
  utils_path = utils_path,
  mdr_filename = mdr_filename
)

source_system_name <- "exampleCSV_source"
target_system_name <- "exampleCSV_target"

rv <- c(rv, create_helper_vars(
  mdr = rv$mdr,
  source_db = source_system_name,
  target_db = target_system_name
))
# save source/target vars
rv$source$system_name <- source_system_name
rv$target$system_name <- target_system_name
rv$source$system_type <- "csv"
rv$target$system_type <- "csv"

rv$log$logfile_dir <- tempdir()

# set headless (without GUI, progressbars, etc.)
rv$headless <- TRUE

# set configs
demo_files <- system.file("demo_data", package = "DQAstats")
Sys.setenv("EXAMPLECSV_SOURCE_PATH" = demo_files)
Sys.setenv("EXAMPLECSV_TARGET_PATH" = demo_files)

# get configs
rv$source$settings <- DIZutils::get_config_env(
  system_name = rv$source$system_name,
  logfile_dir = rv$log$logfile_dir,
  headless = rv$headless
)
rv$target$settings <- DIZutils::get_config_env(
  system_name = tolower(rv$target$system_name),
  logfile_dir = rv$log$logfile_dir,
  headless = rv$headless
)

# set start_time (e.g. when clicking the 'Load Data'-button in shiny
rv$start_time <- format(Sys.time(), usetz = TRUE, tz = "CET")

# define restricting date
rv$restricting_date$use_it <- FALSE

data_loading(
  rv = rv,
  system = rv$source,
  keys_to_test = rv$keys_source
)

}
