#' @title SIGRT litener
#' @noRd

SigListener <- R6::R6Class(
  "SigListener",
  cloneable = F,

  public = list(

    #' @field List containing pointers to signal listeners
    pointers = NULL,

    #' @field Data.frame with available signals
    SIGRTs = NULL,

    initialize = function() {

      self$SIGRTs <- get_SIGRTs()

      # initialize pointers to flags
      self$pointers <- vector(mode = "list", length = nrow(self$SIGRTs))
      names(self$pointers) <- self$SIGRTs$nums

    }
  )
)

#' Initialize listener
#' @noRd
init_listener <- function() {

  if(exists("sigListener", envir = signallR_env))
    return(NULL)
  else
    signallR_env[["sigListener"]] <-
      SigListener$new()

}


#' Check signal validity
#' @noRd
check_signal <- function(signal) {

  init_listener()

  if (grepl(x = signal, pattern = "^SIGRTMIN")) {

    signum <- signallR_env$sigListener$SIGRTs[
      signallR_env$sigListener$SIGRTs$SIGRTMIN == signal, "nums"
    ]

  } else if (grepl(x = signal, pattern = "^SIGRTMAX")) {

    signum <- signallR_env$sigListener$SIGRTs[
      signallR_env$sigListener$SIGRTs$SIGRTMAX == signal, "nums"
    ]

  } else {

    if (signal %in% signallR_env$sigListener$SIGRTs$nums)
      signum <- signal

    else
      signum <- NULL

  }

  return(signum)

}



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
#' @return boolean indicating if initializing procedure began successfully
#' @export

SIGRT_listen <- function(signal) {

  # check the type of the provided signal and return its integer

  signum <- check_signal(signal)

  if (is.null(signum))
    stop("Value provided in 'signal' is not available as a SIGRT signal on your ",
         "system. Check 'get_SIGRTs()' function for table of available ones.")

  .Call(.C_R_setupSIGRTflag, signum)

}

#' Check signal
#' @export

SIGRT_check <- function() {

  .Call(.C_R_checkSIGRTflag)

}
