% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/kaleido.R
\name{save_image}
\alias{save_image}
\alias{kaleido}
\title{Save plot as a static image}
\usage{
save_image(p, file, ..., width = NULL, height = NULL, scale = NULL)

kaleido(...)
}
\arguments{
\item{p}{a plot object.}

\item{file}{a file path with a suitable file extension (png, jpg, jpeg,
webp, svg, or pdf).}

\item{...}{not currently used.}

\item{width, height}{The width/height of the exported image in layout
pixels. If \code{scale} is 1, this will also be the width/height of the exported
image in physical pixels.}

\item{scale}{The scale factor to use when exporting
the figure. A scale factor larger than 1.0 will increase the image
resolution with respect to the figure's layout pixel dimensions. Whereas as
scale factor of less than 1.0 will decrease the image resolution.}
}
\value{
For \code{save_image()}, the generated \code{file}. For \code{kaleido()}, an environment that contains:
\itemize{
\item \code{transform()}: a function to convert plots objects into static images. This function has the same signature (i.e., arguments) as \code{save_image()}
\item \code{shutdown()}: a function for shutting down any currently running subprocesses
that were launched via \code{transform()}
\item \code{scope}: a reference to the underlying \code{kaleido.scopes.plotly.PlotlyScope}
python object. Modify this object to customize the underlying Chromium
subprocess and/or configure other details such as URL to plotly.js, MathJax, etc.
}
}
\description{
Static image exporting via \href{https://github.com/plotly/Kaleido/}{the kaleido python package}. \code{kaleido()} imports
kaleido into a \pkg{reticulate}d Python session and returns a \verb{$transform()}
method for converting R plots into static images. \code{save_image()} provides a convenience wrapper around \code{kaleido()$transform()}.
}
\section{Installation}{


\code{kaleido()} requires \href{https://github.com/plotly/Kaleido/}{the kaleido python package} to be usable via the
\pkg{reticulate} package. If you're starting from scratch, you install
eveything you need with the following R code:

\if{html}{\out{<div class="sourceCode">}}\preformatted{install.packages("reticulate")
library(reticulate)
use_python(install_python())
py_install(c("kaleido", "plotly"))
}\if{html}{\out{</div>}}
}

\examples{
\dontshow{if (interactive() || !identical(.Platform$OS.type, "windows")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}

\dontrun{
  # Save a single image
  p <- plot_ly(x = 1:10)
  tmp <- tempfile(fileext = ".png")
  save_image(p, tmp)
  file.show(tmp)

  # Efficiently save multiple images
  scope <- kaleido()
  for (i in 1:5) {
    scope$transform(p, tmp)
  }
  # Remove and garbage collect to remove 
  # R/Python objects and shutdown subprocesses
  rm(scope); gc()
}
\dontshow{\}) # examplesIf}
}
