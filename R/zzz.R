.onUnload <- function (libpath) {
  library.dynam.unload("signallR", libpath)
}

signallR_env <- new.env()

#' @useDynLib signallR, .registration = TRUE, .fixes = ".C_"
NULL
