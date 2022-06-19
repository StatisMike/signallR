#include <R.h>
#include <Rinternals.h>
#include <signal.h>
#include <errno.h>

// get all valid signal integers
SEXP R_getValidSigrts() {

  int n_sigs = SIGRTMAX - SIGRTMIN + 1;

  SEXP valid_SIGRT = PROTECT(allocVector(INTSXP, n_sigs));

  for (int i = 0; i < n_sigs; i++) {

    INTEGER(valid_SIGRT)[i] = SIGRTMIN + i;

  }

  UNPROTECT(1);
  return valid_SIGRT;

}

// send signal to another process
SEXP R_sendSigrt(SEXP r_pid, SEXP r_signum) {

  int signum = Rf_asInteger(r_signum);
  int pid = Rf_asInteger(r_pid);
  int out;

  errno = 0;
  int ret = kill(pid, signum);
  if (ret == -1) {
    if (errno == EPERM)
      out = -1;
    else if (errno == ESRCH)
      out = -2;
    else
      out = 0;
  } else {
    out = 1;
  }

  return Rf_ScalarInteger(out);
}
