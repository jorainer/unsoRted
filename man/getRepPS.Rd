\name{getRepPS}
\alias{getRepPS}
\title{
Select a representative probe set for a gene based on e.g. it's variance
in expression
}
\description{
This function allows to select a probe set for a gene based on some
criteria like the highest average expression across samples, highest
variance, lowest p-value or any score that can be calculated on
e.g. expression values. The function allows also to incorporate
additional information to the selection criteria, i.e. whether the
transcript detected by the probe set is protein coding or (for
Affymetrix ST microarrays) the number of
probes on the microarray that detect that transcript.
}
\usage{
getRepPS( x, annot, FUN=function( z ){ mean( z ) * sd( z ) }, order.decreasing=TRUE, v=TRUE, gene.id.col="gene_id", probeset.id.col="probeset_id", transcript.biotype.col="transcript_biotype", prefer.protein.coding=TRUE, probe.count.col="probe_count", probe.count.cut=c( 9, 7, 5 ), mc.cores=getOption( "mc.cores", 2L ) )
}
\arguments{
  \item{x}{
    Either a matrix with numeric values (rownames being probe set ids)
    or an \dQuote{ExpressionSet}.
  }
  \item{annot}{
    A data.frame with annotations for the probe set ids. Has to provide
    at least two columns named according to the parameters
    \dQuote{probeset.id.col} and \dQuote{gene.id.col} specifying the
    probe set and gene ids, respectively.
  }
  \item{FUN}{
    The function to be applied to the numerical values for each row in x
    to calculate the score based on which the representative probe set
    will be selected.
  }
  \item{order.decreasing}{
    Whether the above calculated scores should be ordered increasing or
    decreasing. The representative probe set will be the first on in the
    ordered list.
  }
  \item{v}{
    Verbosity.
  }
  \item{gene.id.col}{
    The name of the column in \dQuote{annot} that contains the gene ids (can be
    non-unique).
  }
  \item{probeset.id.col}{
    The name of the column in \dQuote{annot} that contains the probe set
    ids (have to be unique).
  }
  \item{transcript.biotype.col}{
    Optional; the name of the column in \dQuote{annot} that specifies
    whether the transcript detected by the probe set is protein coding
    (internally the function greps for \dQuote{protein}) in the
    respective column.
  }
  \item{prefer.protein.coding}{
    Boolean specifying whether protein coding transcripts should be
    preferred over non-coding transcripts.
  }
  \item{probe.count.col}{
    The name of the column in \dQuote{annot} that provides the number of
    probes for each probe set.
  }
  \item{probe.count.cut}{
    A numerical vector specifying potential cut-off values for the probe
    counts. With the default setting, the function will check whether
    there are probe sets for a gene with a number of probes bigger or
    equal to 9, and, if so excludes all probe sets with less. The
    function will iterate through the numerical vector and apply the
    above described search for each cut-off value. This will select for
    each gene more stable probe sets, i.e. probe sets with more probes,
    as the variance of a probe set across technical replicates decreases
    with the number of probes (unpublished observation).
  }
  \item{mc.cores}{
    The number of cores that should be used to process the code.
  }
}
\details{
  This function may not only be used for the above mentioned use case,
  generally it can be used to select one entry among many for e.g. the
  same entity based on some provided or calculated values (see examples
  below).
  In detail, the function uses the entries in column
  \dQuote{gene.id.col} to split the data (using \code{split}) and performs the representative
  probe set search using \code{mclapply}.
  This approach to select a representative probe set for a given gene
  has been used, and was developed, in the publications listed in the
  reference section.
}
\value{
  A character vector with the probe set IDs of the representative probe
  sets for each given gene with the gene names used as names of the
  character vector.
}
\references{

  Rainer J, Lelong J, Bindreither D, Mantinger C, Ploner C, Geley S,
  Kofler R. (2012) Research resource: transcriptional response to
  glucocorticoids in childhood acute lymphoblastic leukemia. Mol Endocrinol. \bold{26},:178--93.

  Aneichyk T, Bindreither D, Mantinger C, Grazio D, Goetsch K, Kofler R
  and Rainer J (2013) Translational profiling in childhood acute
  lymphoblastic leukemia: no evidence for glucocorticoid regulation of
  mRNA translation. BMC Genomics \bold{14}, 844.

  http://bioinfo.i-med.ac.at
}
\author{
  Johannes Rainer
}
\examples{

annotation <- data.frame( gene_id=c( "a", "a", "b", "b", "a" ), probeset_id=c( "a1", "a2", "b1", "b2", "a3" ), stringsAsFactors=FALSE )

data <- matrix( c( 4, 5, 2, 1, 3, 4, 4, 7, 3, 2 ) , ncol=2, byrow=TRUE )
rownames( data ) <- annotation$probeset_id

data

## return for each gene the probe set with the highest average expression
best.ps <- getRepPS( x=data, annot=annotation, FUN=function( z ){ mean( z ) } )

data[ best.ps,  ]

}
\keyword{ data }
