\name{unsoRted-package}
\alias{unsoRted-package}
\alias{unsoRted}
\docType{package}
\title{
Unsorted collection of functions and utilities
}
\description{
This package contains some utilities and functions.
}
\details{

  The functions provided by this package are:

  Data analysis:

  \itemize{

    \item getAnnotation: retrieves an annotation data.frame for a given
    (Affymetrix based) \dQuote{ExpressionSet}. For more informations see
    \code{\link{getAnnotation}}.

    \item getAnnotationForIDs: retrieves a data.frame with annotations
    for the provided feature (probe set) ids. For more informations see \code{\link{getAnnotationForIDs}}.

    \item getRepPS: returns a representative probe set for a gene based
    on some criteria. For more informations see \code{\link{getRepPS}}.

    \item hyperGGeneric: performs a category analysis on any user
    provided definition of categories. For more informations see \code{\link{hyperGGeneric}}.

  }

  Visualizations:

  \itemize{
    \item plotCategoryBar and plotCategoryBars: visualization of
    category enrichment analysis results. For more informations
    see \code{\link{plotCategoryBar}}.

    \item modColor, shiftColor and invertColor: shift or invert colors
  in RGB or HSV color space. See examples in \code{\link{modColor}}.
  }

  Utilities:

  \itemize{

    \item convertTxt2Xls: converts a text file with tabular content to a
    Microsoft Excel spreadsheet. For more informations see \code{\link{convertTxt2Xls}}.

    \item load.from.http: loads a RData file from a remote server
    (e.g. http or ftp server). For more informations see \code{\link{load.from.http}}.

    \item pastedmatch: value matching allowing e.g. \dQuote{;} separated
    values. For more informations see \code{\link{pastedmatch}}.

    \item read.table.from.http: loads and reads a table from a remote
  (e.g. http or ftp) server. For more information see
  \code{\link{read.table.from.http}}.
  }

}
\author{
Daniel Bindreither, Johannes Rainer

Maintainer: Johannes Rainer <johannes.rainer@gmail.com>
}
\references{
http://bioinfo.i-med.ac.at
}
\keyword{ package }
