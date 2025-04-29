
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
#' @inheritParams ggplot2::geom_bar
#' @param stat Always set to the "identity" statistic.
#' @param position Always set to the "dodgediff" position.
#' @param backwards Whether or not to create backwards hats when the difference is negative.
#'
#' @returns A `ggproto` object of class `GeomHat`.
#'
#' @export
#'
#' @examples
#'
#' library(tidyverse)
#'
#' my_data <- tibble( # Create summarized data by treatment group, before and after
#'   treatment = c("A", "B", "C", "D"),
#'   pre_treatment_mean = c(50, 49, 48, 50),
#'   post_treatment_mean = c(51, 53, 55, 52)
#' ) |>
#'   pivot_longer(!treatment, names_to = "condition", values_to = "mean") |> # Format as long data
#'   mutate(condition = fct_relevel(condition, "pre_treatment_mean",
#'                                 "post_treatment_mean")) # Order properly
#'
#' ggplot(my_data, aes(x = treatment, y = mean, group = condition)) +
#'   geom_hat(width = 0.75, linewidth = 0.75, # Add hat geoms
#'            fill = "black", color = "black", alpha = 0.25) +
#'   geom_text(aes(label = mean), family = "Courier", # And direct labels
#'             position = position_dodgedifftext(width = 0.75, nudge = 0.6)) +
#'   scale_y_continuous(expand = c(0, 0)) +
#'   coord_cartesian(ylim = c(40, 60)) +
#'   theme_minimal() +
#'   theme(
#'     text = element_text(family = "Courier"),
#'     legend.position = "none",
#'     panel.grid = element_blank(),
#'     axis.line = element_line(linewidth = 0.5),
#'     axis.ticks = element_line(linewidth = 0.5),
#'     plot.title = element_text(hjust = 0.5)
#'   ) +
#'   xlab("Treatment") +
#'   ylab("Measurement") +
#'   ggtitle("Measurements PRE- and POST-treatment") # An example of just one use for hat graphs
#'
geom_hat <- function(mapping = NULL, data = NULL,
                     stat = "identity",
                     backwards = FALSE,
                     position = position_dodgediff(backwards = backwards),
                     ...,
                     just = 0.5,
                     width = 0.75,
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


