% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mice.factorize.R
\name{mice.factorize}
\alias{mice.factorize}
\title{Transform Imputations of Binarized Data Into Their Corresponding Factors}
\usage{
mice.factorize(obj, par_list)
}
\arguments{
\item{obj}{\code{mice::mids} object resulting from a call of
\code{mice.post.matching()} and whose underlying data frame results from a
call of \code{mice::binarize()}.}

\item{par_list}{List that has been returned in a previous call of
\code{mice::binarize()} next to the underlying data of the argument
\code{obj}.}
}
\value{
A \code{mice::mids} object in which data and imputations have been
 retransformed from their respective binarized versions in the input
 \code{obj}. As this isn't a proper result of a mice iteration and many of
 the attributes of \code{obj} cannot be transformed well, only the slots
 \code{data}, \code{nmis}, \code{where} and \code{imp}, which are needed in
 \code{with()} are not \code{NULL}. Hence, it does not work as input for
 \code{mice.mids()}.
}
\description{
This function acts as the counterpart to \code{mice.binarize}, as it
effectively retransforms imputations of binarized data that \code{mice} has
been run on and that has been post-processed via \code{mice.post.matching}
after. The post-processing is usually necessary as \code{mice} is very likely
to impute multiple ones among the dummy columns belonging to to a single
factor entry. The resulting \code{mice::mids} object is not suited for further
\code{mice.mids()} iterations or the use of \code{plot}, but works well as
input to \code{with()}.
}
\examples{


\dontrun{
#------------------------------------------------------------------------------
# this example illustrates the combined functionalities of mice.binarize,
# mice.factorize and mice.post.matching on the dataset 'boys' from mice, which
# yields different imputations on the factor columns 'gen', 'phb' and 'reg'
# than mice() would output
#------------------------------------------------------------------------------

# binarize all factor columns in boys_data that contain NAs
boys_bin <- mice.binarize(boys)

# run mice on binarized data, note that we need to use boys_bin$data to grab
# the actual binarized data and that we use the output predictor matrix
# boys_bin$pred_matrix which is recommended for obtaining better imputation
# models
mids_boys <- mice(boys_bin$data, predictorMatrix = boys_bin$pred_matrix)

# it is very likely that mice imputed multiple ones among one set of dummy
# variables, so we need to post-process
post_boys <- mice.post.matching(mids_boys, distmetric = "residual")

# now we can safely retransform to the original data, with non-binarized imputations
res_boys <- mice.factorize(post_boys$midsobj, boys_bin$par_list)

# analyze the distribution of imputed variables, e.g. of the column 'gen',
# using the mice version of with()
with(res_boys, table(gen))
}



}
\seealso{
\code{\link[miceExt]{mice.binarize}},
 \code{\link[miceExt]{mice.post.matching}}, \code{\link[mice]{mice}}
}
\author{
Tobias Schumacher, Philipp Gaffert
}