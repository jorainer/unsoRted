\name{convertTxt2Xls}
\alias{convertTxt2Xls}
\title{
Convert a table in text format to an Excel table
}
\description{
This function takes the file name(s) of one or more text files with
tabular content and converts them to Microsoft Excel spreadsheets.
}
\usage{
convertTxt2Xls(file, sep = "\t", as.is=TRUE, header=TRUE, xls = "xlsx",
... )
}
\arguments{
  \item{file}{
    The name of the file (or character vector of file names) to be
    converted.
}
\item{sep}{
  The field separator character. Passed directly to the
  \code{\link{read.table}} function.
}
\item{as.is}{
  a logical value defining whether strings should be converted to
  factors. Passed directly to the
  \code{\link{read.table}} function.
}
\item{header}{
  a logical value indicating whether the file contains (in the first
  line) the column names. Passed directly to the
  \code{\link{read.table}} function.
}
\item{xls}{
  a string specifying the output format (either \dQuote{xls} or \dQuote{xlsx}).
}
\item{...}{
  further arguments passed to the
  \code{\link{read.table}} function.
}
}
\details{
  The function invokes the \sQuote{WriteXLS} function from the package \sQuote{WriteXLS}.
}
\value{
  No return value.
}
\references{
  http://bioinfo.i-med.ac.at
}
\author{
  Johannes Rainer
}

\keyword{ data }
