#' @title Send SIGRT signal to process
#' @description Providing the process PID send one of the valid SIGRT signals
#' to that process
#' @param signal Valid UNIX SIGRT signal to listen for. Either its integer value
#' or name beginning with "SIGRTMIN" or "SIGRTMAX".
#' @param pid *integer* with PID of the receiving process. Defaults to value of
#' `Sys.getpid()`, sending signal to current process.
#' @return *boolean* indicating if signal have been sent
#' @example examples/SIGRT_basics.R
#' @export
SIGRT_send <- function(signal, pid = Sys.getpid()) {

  signum <- check_signal(signal)

  if (is.null(signum))
    stop("Value provided in 'signal' is not available as a SIGRT signal on your ",
         "system. Check 'get_SIGRTs()' function for table of available ones.")

  if (!is.integer(pid) || length(pid) != 1)
    stop("Value provided to `pid` need to be single integer.")

  out <- .Call(.C_R_sendSigrt, pid, signum, PACKAGE = "signallR")

  if (out == 1)
    return(TRUE)
  if (out == -1)
    warning("Don't have permissions to send signal to this process.")
  if (out == -2)
    warning("Process of specified `pid` don't exist.")
  if (out == 0)
    warning("Couldn't send the signal.")
  return(FALSE)


}
