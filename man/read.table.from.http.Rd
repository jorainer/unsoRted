\name{read.table.from.http}
\alias{read.table.from.http}
\alias{load.from.http}
\title{
Read table or load RData objects from a remote server
}
\description{
These functions read tables or load RData objects stored on a remote
server (e.g. from http or ftp servers).
}
\usage{
read.table.from.http( x, ... )
load.from.http( x, ... )
}
\arguments{
  \item{x}{
    The url pointing to the file.
  }
  \item{...}{
    Further arguments passed to the functions \code{read.table} or
    \code{load}, respectively.
  }
}
\value{
  In case of \code{read.table.from.http} the table. \code{load} will load
  the variable stored in the RData file into the workspace.
}
\details{
  Internally, the function downloads the file first to the temporary
  folder and reads or loads the thus downloaded file. This is much
  faster than calling \code{read.table} or \code{load} providing the url
  as file name.
}
\references{
  http://bioinfo.i-med.ac.at
}
\author{
  Johannes Rainer
}
\keyword{ data }
