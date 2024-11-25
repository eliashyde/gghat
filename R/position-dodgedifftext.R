
#' Dodged Difference for Text
#'
#' @param width Relative width of bars and the like.
#' @param nudge Nudge direct labels up and down away from hat.
#' @param backwards Whether or not to create backwards hats when the difference is negative.
#'
#' @export
position_dodgedifftext <- function(width = NULL, nudge = 1, backwards = FALSE) {
  ggplot2::ggproto(NULL, PositionDodgeDiffText, width = width, nudge = nudge, backwards = backwards)
}

PositionDodgeDiffText <- ggplot2::ggproto("PositionDodgeDiffText", ggplot2::PositionDodge,
                                 setup_params = function(self, data) {
                                   params <- ggplot2::ggproto_parent(PositionDodge, self)$setup_params(data)
                                   params$nudge <- self$nudge
                                   params$backwards <- self$backwards
                                   return(params)
                                 },
                                 compute_panel= function(self, data, params, scales) {
                                   data$y <- data$y + params$nudge
                                   data$id <- data$x
                                   data <- ggplot2::ggproto_parent(PositionDodge, self)$compute_panel(data, params, scales)
                                   data_groups <- split(data, data$id)
                                   data <- do.call(rbind, lapply(data_groups, function(group) {
                                     for (i in seq_along(group$y)) {
                                       if (group$y[1] > group$y[i] & !params$backwards) {
                                         group$y[i] = group$y[i] - (2 * params$nudge)
                                       }
                                     }
                                     return(group)
                                   }))
                                   return(data)
                                 }
)


