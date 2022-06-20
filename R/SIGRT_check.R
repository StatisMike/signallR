#' @title Began listening for SIGRT signal
#' @param signal Valid UNIX SIGRT signal to listen for. Either its integer value
#' or name beginning with "SIGRTMIN" or "SIGRTMAX".
#' @description
#' Before running checks for particular signal, it is mandatory to first call
#' this function - it installs the custom handler for specified signal.
#'
#' As available SIGRT signals vary from system to system, you can check the
#' list of available signals with [get_SIGRTs()].
#'
#' @return boolean indicating if initializing procedure have been completed.
#' `FALSE` means that the listening procedure have been intialized before
#' @export

SIGRT_listen <- function(signal) {

  # check the type of the provided signal and return its integer

  signum <- check_signal(signal)

  if (is.null(signum))
    stop("Value provided in 'signal' is not available as a SIGRT signal on your ",
         "system. Check 'get_SIGRTs()' function for table of available ones.")

  signum <- as.character(signum)

  if (!is.null(signallR_env$sigListener$checkers[[signum]]))
    return(FALSE)

  # check if any base handlers are available
  i <- signallR_env$sigListener$get_empty_handler()

  if (!is.null(i)) {
    signallR_env$sigListener$register_check(i, signum)
    message("Precompiled handler for signal '", signal, "' have been registered.")
  } else {
    signallR_env$sigListener$register_add_check(signum)
    signallR_env$sigListener$checkers[[signum]](1)
    message("Inline handler for signal '", signal, "' have been compiled and registered.")
  }

  return(TRUE)

}

#' Check if chosen signal have been received
#' @param signal Valid UNIX SIGRT signal to listen for. Either its integer value
#' or name beginning with "SIGRTMIN" or "SIGRTMAX".
#' @param *boolean* indicating if the flag for given signal should be set to `0`
#' after check
#' @export

SIGRT_check <- function(signal, refresh = F) {

  signum <- check_signal(signal)

  if (is.null(signum))
    stop("Value provided in 'signal' is not available as a SIGRT signal on your ",
         "system. Check 'get_SIGRTs()' function for table of available ones.")

  signum <- as.character(signum)

  if (is.null(signallR_env$sigListener$checkers[[signum]]))
    stop("No checks are being made for signal: '", signal, "' yet. Initialize",
         " checks with 'SIGRT_liste()' first.")

  refresh <- if (isTRUE(refresh)) 1 else 0

  signallR_env$sigListener$checkers[[signum]](refresh)

}
