% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom-hat.R
\name{geom_hat}
\alias{geom_hat}
\title{The Hat Geom}
\usage{
geom_hat(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  backwards = FALSE,
  position = position_dodgediff(backwards = backwards),
  ...,
  just = 0.5,
  width = 0.75,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)
}
\arguments{
\item{mapping}{Set of aesthetic mappings created by \code{\link[ggplot2:aes]{aes()}}. If specified and
\code{inherit.aes = TRUE} (the default), it is combined with the default mapping
at the top level of the plot. You must supply \code{mapping} if there is no plot
mapping.}

\item{data}{The data to be displayed in this layer. There are three
options:

If \code{NULL}, the default, the data is inherited from the plot
data as specified in the call to \code{\link[ggplot2:ggplot]{ggplot()}}.

A \code{data.frame}, or other object, will override the plot
data. All objects will be fortified to produce a data frame. See
\code{\link[ggplot2:fortify]{fortify()}} for which variables will be created.

A \code{function} will be called with a single argument,
the plot data. The return value must be a \code{data.frame}, and
will be used as the layer data. A \code{function} can be created
from a \code{formula} (e.g. \code{~ head(.x, 10)}).}

\item{stat}{Always set to the "identity" statistic.}

\item{backwards}{Whether or not to create backwards hats when the difference is negative.}

\item{position}{Always set to the "dodgediff" position.}

\item{...}{Other arguments passed on to \code{\link[ggplot2:layer]{layer()}}'s \code{params} argument. These
arguments broadly fall into one of 4 categories below. Notably, further
arguments to the \code{position} argument, or aesthetics that are required
can \emph{not} be passed through \code{...}. Unknown arguments that are not part
of the 4 categories below are ignored.
\itemize{
\item Static aesthetics that are not mapped to a scale, but are at a fixed
value and apply to the layer as a whole. For example, \code{colour = "red"}
or \code{linewidth = 3}. The geom's documentation has an \strong{Aesthetics}
section that lists the available options. The 'required' aesthetics
cannot be passed on to the \code{params}. Please note that while passing
unmapped aesthetics as vectors is technically possible, the order and
required length is not guaranteed to be parallel to the input data.
\item When constructing a layer using
a \verb{stat_*()} function, the \code{...} argument can be used to pass on
parameters to the \code{geom} part of the layer. An example of this is
\code{stat_density(geom = "area", outline.type = "both")}. The geom's
documentation lists which parameters it can accept.
\item Inversely, when constructing a layer using a
\verb{geom_*()} function, the \code{...} argument can be used to pass on parameters
to the \code{stat} part of the layer. An example of this is
\code{geom_area(stat = "density", adjust = 0.5)}. The stat's documentation
lists which parameters it can accept.
\item The \code{key_glyph} argument of \code{\link[ggplot2:layer]{layer()}} may also be passed on through
\code{...}. This can be one of the functions described as
\link[ggplot2:draw_key]{key glyphs}, to change the display of the layer in the legend.
}}

\item{just}{Adjustment for column placement. Set to \code{0.5} by default, meaning
that columns will be centered about axis breaks. Set to \code{0} or \code{1} to place
columns to the left/right of axis breaks. Note that this argument may have
unintended behaviour when used with alternative positions, e.g.
\code{position_dodge()}.}

\item{width}{Bar width. By default, set to 90\% of the \code{\link[ggplot2:resolution]{resolution()}} of the
data.}

\item{na.rm}{If \code{FALSE}, the default, missing values are removed with
a warning. If \code{TRUE}, missing values are silently removed.}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.
It can also be a named logical vector to finely select the aesthetics to
display.}

\item{inherit.aes}{If \code{FALSE}, overrides the default aesthetics,
rather than combining with them. This is most useful for helper functions
that define both data and aesthetics and shouldn't inherit behaviour from
the default plot specification, e.g. \code{\link[ggplot2:borders]{borders()}}.}
}
\value{
A \code{ggproto} object of class \code{GeomHat}.
}
\description{
The hat geom functions much like a bar or col geom with stat = "identity" and
position = "dodge." It requires x, y, and group aesthetics, and it takes the
same parameters. However, the hat geom adopts "dodgediff" as its default position.
And as well as the parameters characteristic of bars, the hat geom may also be
passed a bool to direct its behavior in the case of negative difference, when
there is a decrease from a baseline for instance. This bool is the backwards
parameter described below.
}
\examples{

library(tidyverse)

my_data <- tibble( # Create summarized data by treatment group, before and after
  treatment = c("A", "B", "C", "D"),
  pre_treatment_mean = c(50, 49, 48, 50),
  post_treatment_mean = c(51, 53, 55, 52)
) |>
  pivot_longer(!treatment, names_to = "condition", values_to = "mean") |> # Format as long data
  mutate(condition = fct_relevel(condition, "pre_treatment_mean",
                                "post_treatment_mean")) # Order properly

ggplot(my_data, aes(x = treatment, y = mean, group = condition)) +
  geom_hat(width = 0.75, linewidth = 0.75, # Add hat geoms
           fill = "black", color = "black", alpha = 0.25) +
  geom_text(aes(label = mean), family = "Courier", # And direct labels
            position = position_dodgedifftext(width = 0.75, nudge = 0.6)) +
  scale_y_continuous(expand = c(0, 0)) +
  coord_cartesian(ylim = c(40, 60)) +
  theme_minimal() +
  theme(
    text = element_text(family = "Courier"),
    legend.position = "none",
    panel.grid = element_blank(),
    axis.line = element_line(linewidth = 0.5),
    axis.ticks = element_line(linewidth = 0.5),
    plot.title = element_text(hjust = 0.5)
  ) +
  xlab("Treatment") +
  ylab("Measurement") +
  ggtitle("Measurements PRE- and POST-treatment") # An example of just one use for hat graphs

}
