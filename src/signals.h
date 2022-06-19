#ifndef SIGNALS_H
#define SIGNALS_H

#include <R.h>
#include <Rinternals.h>
#include <signal.h>

SEXP R_getValidSigrts();
SEXP R_sendSigrt(SEXP r_pid, SEXP r_signum);

#endif
