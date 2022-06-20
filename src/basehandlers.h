#ifndef BASEHANDLERS_H
#define BASEHANDLERS_H

#include <R.h>
#include <Rinternals.h>
#include <signal.h>

SEXP R_regListener1Base (SEXP r_signum);
SEXP R_regListener2Base (SEXP r_signum);
SEXP R_regListener3Base (SEXP r_signum);
SEXP R_regListener4Base (SEXP r_signum);
SEXP R_regListener5Base (SEXP r_signum);

SEXP R_sigChecker1Base (SEXP r_refresh);
SEXP R_sigChecker2Base (SEXP r_refresh);
SEXP R_sigChecker3Base (SEXP r_refresh);
SEXP R_sigChecker4Base (SEXP r_refresh);
SEXP R_sigChecker5Base (SEXP r_refresh);

#endif
