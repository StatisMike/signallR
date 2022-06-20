#' @title SIGRT listener
#' @noRd

SigListener <- R6::R6Class(
  "SigListener",
  cloneable = F,

  public = list(

    #' @field handlers Vector showing base
    handlers = rep(FALSE, 5),

    #' @field checkers List containing cfuncs for checks
    checkers = NULL,

    #' @field SIGRTs Data.frame with available signals
    SIGRTs = NULL,

    initialize = function() {

      self$SIGRTs <- SIGRT_get_int()

      # initialize checkers list
      self$checkers <- vector(mode = "list", length = nrow(self$SIGRTs))
      names(self$checkers) <- self$SIGRTs$nums

    },

    #' @description Get first empty base handler
    get_empty_handler = function() {

      if (sum(self$handlers) != 5)
        return(min(which(self$handlers == FALSE)))
      else
        return(NULL)

    },

    #' @description Register new base handler
    #' @param i number of handler that should be registered
    #' @param signum signal number to register handler for
    register_check = function(i, signum) {

      hand_name <- paste0(".C_R_regListener", i, "Base")
      check_name <- paste0(".C_R_sigChecker", i, "Base")

      hand_code <- paste0(".Call(", hand_name,", ",signum,", PACKAGE = 'signallR')")
      eval(str2lang(hand_code))

      checker_code <- paste0(
        "function(refresh) .Call(", check_name, ", refresh, PACKAGE = 'signallR')")

      self$checkers[[as.character(signum)]] <-
        eval(str2lang(checker_code))

      self$handlers[i] <- TRUE

    },

    #' @description Create checker for provided signum
    #' @param signum integer for signum

    register_add_check = function(signum) {

      if (!requireNamespace("inline", quietly = T))
        stop("To register more than 5 SIGRT listeners please install 'inline' package.")

      signum <- as.character(signum)

      flag_name <- paste0("SIGRT_", signum, "_flag")
      handler_name <- paste0("SIGRT_", signum, "_handler")

      # create the flag on C side
      flag_code <- paste0(
        "static volatile sig_atomic_t ",  flag_name, "= 0;")

      # create handler for signal
      handler_code <- paste0(
        "void ", handler_name, " (int signum) {
        ", flag_name, "++;
     }"
      )

      # create new sigaction
      sigaction_code <- paste0(
        "
        void register_sigaction_", signum, " () {

        struct sigaction action_", signum, ";
            memset(&action_", signum, ", 0, sizeof(action_", signum, "));
            action_", signum, ".sa_handler = ", handler_name, ";
            sigaction(", signum, ", &action_", signum, ", NULL);

        return;
        }")

      # create checker
      checker_code <- paste0(

        "
        int refresh = Rf_asInteger(r_refresh);
        register_sigaction_", signum, "();

        int out = ", flag_name,";

         if (refresh == 1)
            ", flag_name, " = 0;

         return Rf_ScalarInteger(out);"
      )

      self$checkers[[signum]] <- inline::cfunction(
        sig = c("r_refresh" = "integer"),
        includes = paste("#include <signal.h>",
                         flag_code,
                         handler_code,
                         sigaction_code,
                         sep = "\n\n"),
        body = checker_code
      )
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
