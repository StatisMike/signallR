#' @noRd
SIGRT_get_int <- function() {

  avail_SIGRTs <- data.frame(nums = .Call(.C_R_getValidSigrts,
                                          PACKAGE = "signallR"))

  avail_SIGRTs[["SIGRTMIN"]] <-
    sapply(seq_along(avail_SIGRTs$nums), \(i) {
      if (i == 1) "SIGRTMIN"
      else paste("SIGRTMIN", i-1, sep = "+")
    })

  avail_SIGRTs[["SIGRTMAX"]] <-
    sapply(seq_along(avail_SIGRTs$nums), \(i) {
      if (i == 1) "SIGRTMAX"
      else paste("SIGRTMAX", i-1, sep = "-")
    })

  avail_SIGRTs[["SIGRTMAX"]] <-
    avail_SIGRTs[["SIGRTMAX"]][nrow(avail_SIGRTs):1]

  return(avail_SIGRTs)

}

#' @title Get data about available SIGRTs
#' @description Data.frame containing all available Real-Time UNIX signals:
#' their number as well as their name as "SIGRTMIN" and "SIGRTMAX"
#' @return data.frame
#' @export
SIGRT_get <- function() {

  init_listener()

  signallR_env$sigListener$SIGRTs

}
