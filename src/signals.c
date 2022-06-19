#include <R.h>
#include <Rinternals.h>
#include <signal.h>

static volatile sig_atomic_t flag = -1;

void handler (int signum) {
  flag++;
}

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

// setup signal flag
SEXP R_setupSIGRTflag(SEXP r_signum) {

  int signum = Rf_asInteger(r_signum);

  struct sigaction action;
  memset(&action, 0, sizeof(action));
  action.sa_handler = handler;
  sigaction(signum, &action, NULL);
  flag = 0;
  return R_NilValue;

}

// check signal flag
SEXP R_checkSIGRTflag() {

  // int signum = Rf_asInteger(r_signum);

  int out;
  switch(flag) {
  case -1:
    out = NA_LOGICAL;
    break;
  case 0:
    out = FALSE;
    break;
  default:
    out = TRUE;
  }

  return Rf_ScalarLogical(out);

}
