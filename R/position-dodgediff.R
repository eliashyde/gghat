
#' The Dodged Difference Position
#'
#' @param width Relative width of brim and crown.
#' @param backwards Whether or not to create backwards hats when the difference is negative.
#'
#' @returns A `ggproto` object of class `PositionDodgeDiff`.
#'
#' @export
position_dodgediff <- function(width = NULL, backwards = FALSE) {
  ggplot2::ggproto(NULL, PositionDodgeDiff, width = width, backwards = backwards)
}

PositionDodgeDiff <- ggplot2::ggproto("PositionDodgeDiff", ggplot2::PositionDodge,
                             setup_params = function(self, data) {
                               params <- ggplot2::ggproto_parent(PositionDodge, self)$setup_params(data)
                               params$backwards <- self$backwards
                               return(params)
                             },
                             compute_panel= function(self, data, params, scales) {
                               data$id <- data$x # assign an id to all bars-to-be at a given x value
                               data <- ggplot2::ggproto_parent(PositionDodge, self)$compute_panel(data, params, scales) # transform data per parent object, dodging bars
                               data_groups <- split(data, data$id) # split data by id to get all bars at a given x
                               data <- do.call(rbind, lapply(data_groups, function(group) { # apply function to each group
                                 group = group[order(group$x), ] # order by x value so as to not rely on user or default factors
                                 if (!params$backwards && group$y[1] < group$y[2]) { # if difference is positive...
                                   group$ymin = group$ymax[1] # make a hat
                                 } else if (!params$backwards && group$y[1] > group$y[2]) { # if not backwards and difference is negative...
                                   group$ymin = group$ymax
                                   group$ymax = group$ymax[1] # make an upside-down hat
                                 } else { # else if backwards and difference is negative...
                                   group$ymin = min(group$ymax) # make a backwards hat
                                 }
                                 return(group)
                               }))
                               return(data)
                             }
)


