% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dirdf_parse.R
\name{dirdf_parse}
\alias{dirdf_parse}
\title{Path Metadata Parsing}
\usage{
dirdf_parse(pathnames, template = NULL, regexp = NULL, colnames = NULL,
  missing = NA_character_, ignore.case = FALSE, perl = TRUE)
}
\arguments{
\item{pathnames}{character vector of pathname(s), e.g. the result of calling
\code{\link[base:dir]{base::dir()}}.}

\item{template}{\link[=templates]{template} character string, e.g.
\code{"Country/Province/City/StationID_Date.ext"}.}

\item{regexp}{regular expression used to parse the file names.
Only one of the arguments \code{regexp} and \code{template} must be specified, i.e.
only one of them can be non-\code{NULL}.}

\item{colnames}{character vector containing the names of the columns in the
data frame. Not required if using \code{template} or if \code{regexp} uses
named capturing groups (see examples), but may still be used to override
column names.}

\item{missing}{value to use for unmatched optional template elements or
regexp capturing groups.}

\item{ignore.case, perl}{If \code{regexp} is used, these are passed to
\code{\link[base:regexpr]{base::regexpr()}}. Note that unlike \code{regexpr()}, the default value
for \code{perl} is \code{TRUE} (to make it more convenient to use named
capture groups, which are only supported in Perl mode).}
}
\description{
Creates a data frame using information from the paths and file names. It
accepts either a template or a regular expression and column names. Similar
to \code{\link[=dirdf]{dirdf()}}, but this takes a vector of pathnames and tries to
match them directly, rather than calling \code{\link[base:dir]{base::dir()}} on them and
matching those results. This is helpful if you want to filter or transform
the set of paths before matching, e.g. to remove any irrelevant filenames
like \file{.gitignore}, \file{.DS_Store}, \file{desktop.ini}.
}
\examples{
path1 <- system.file(package = "dirdf", "examples", "dataset_1")
pathnames1 <- dir(path1)

template1 <- "Year-Month-Day_Assay_Plasmid-Type-Fraction_WellNumber?.extension"
regex1 <- paste0(
  "^(?P<Year>\\\\d{4})-(?P<Month>\\\\d{2})-(?P<Day>\\\\d{2})",
  "_(?P<Assay>[a-zA-Z0-9]+)_(?P<Plasmid>[a-zA-Z0-9]+)",
  "-(?P<Type>[a-zA-Z0-9]+)-(?P<Fraction>[a-zA-Z0-9\\\\-]+)",
  "(?:_(?P<WellNumber>\\\\w+))?\\\\.csv$"
)
regex1a <- paste0(
  "^(\\\\d{4})-(\\\\d{2})-(\\\\d{2})_([a-zA-Z0-9]+)_([a-zA-Z0-9]+)",
  "-([a-zA-Z0-9]+)-([a-zA-Z0-9\\\\-]+)(?:_(\\\\w+))?\\\\.csv$"
)
names_regex1a <- c("Year", "Month", "Day", "Assay", "Plasmid", "Type", "Fraction", "WellNumber")

dirdf_parse(pathnames1, template1)
dirdf_parse(pathnames1, regexp = regex1)
dirdf_parse(pathnames1, regexp = regex1a, colnames = names_regex1a)

path2 <- system.file(package = "dirdf", "examples", "dataset_2")
pathnames2 <- dir(path2)
template2 <- "Date_Assay_Experiment_WellNumber?.extension"
dirdf_parse(pathnames2, template2)
}
\seealso{
\code{\link[=dirdf]{dirdf()}}
}
