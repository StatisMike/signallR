#ifndef SIGNALS_H
#define SIGNALS_H

#include <R.h>
#include <Rinternals.h>
#include <signal.h>

SEXP R_getValidSigrts();
SEXP R_setupSIGRTflag(SEXP r_signum);
SEXP R_checkSIGRTflag();

#endif
