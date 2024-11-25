
#' The Hat Geom
#'
#' The hat geom functions much like a bar or col geom with stat = "identity" and
#' position = "dodge." It requires x, y, and group aesthetics, and it takes the
#' same parameters. However, the hat geom adopts "dodgediff" as its default position.
#' And as well as the parameters characteristic of bars, the hat geom may also be
#' passed a bool to direct its behavior in the case of negative difference, when
#' there is a decrease from a baseline for instance. This bool is the backwards
#' parameter described below.
#'
#' @param backwards Whether or not to create backwards hats when the difference is negative.
#'
#' @export
geom_hat <- function(mapping = NULL, data = NULL,
                     stat = "identity",
                     backwards = FALSE,
                     position = position_dodgediff(backwards = backwards),
                     ...,
                     just = 0.5,
                     width = NULL,
                     na.rm = FALSE,
                     show.legend = NA,
                     inherit.aes = TRUE) {

  ggplot2::layer(
    data = data,
    mapping = mapping,
    geom = GeomHat,
    position = position,
    stat = stat,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      just = just,
      width = width,
      na.rm = na.rm,
      ...
    )
  )
}

GeomHat <- ggplot2::ggproto("GeomHat", ggplot2::GeomBar,
                   required_aes = c("x", "y", "group"),
                   default_aes = ggplot2::aes(
                     fill = "grey40",
                     color = "grey40",
                     linewidth = 0.75,
                     linetype = 1,
                     alpha = NA
                   )
)


