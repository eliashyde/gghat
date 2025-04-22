
#' Dodged Difference for an Error Bar
#'
#' @param width Relative width of error bars.
#' @param backwards Whether or not to create backwards hats when the difference is negative.
#'
#' @returns A `ggproto` object of class `PositionDodgeDiffError`.
#'
#' @export
position_dodgedifferror <- function(width = NULL, backwards = FALSE) {
  ggplot2::ggproto(NULL, PositionDodgeDiffError, width = width, backwards = backwards)
}

PositionDodgeDiffError <- ggplot2::ggproto("PositionDodgeDiffError", ggplot2::PositionDodge,
                                  setup_params = function(self, data) {
                                    params <- ggplot2::ggproto_parent(PositionDodge, self)$setup_params(data)
                                    params$backwards <- self$backwards
                                    return(params)
                                  },
                                  compute_panel= function(self, data, params, scales) {
                                    data$id <- data$x
                                    data <- ggplot2::ggproto_parent(PositionDodge, self)$compute_panel(data, params, scales)
                                    data_groups <- split(data, data$id)
                                    data <- do.call(rbind, lapply(data_groups, function(group) {
                                      if (!params$backwards) {
                                        group = group[-1, ]
                                      } else {
                                        group = group[-which.min(group$y), ]
                                      }
                                      return(group)
                                    }
                                    ))
                                    return(data)
                                  }
)


