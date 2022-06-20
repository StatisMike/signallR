
<!-- README.md is generated from README.Rmd. Please edit that file -->

# signallR

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

Package provides utilities to send (and, most importantly: receive)
**SIGRT** UNIX signals in R process.

Currently `R` itself don’t really have any built-in gentle way to
intercept any UNIX signal and react to it. **SIGTERM** causes the
process to abruptly end, and **SIGUSR1** and **SIGUSR2** have
well-defined and unchangeable default behavior - that finally leads to
the same: termination of the process.

There is another group of UNIX signals that don’t have a defined
behavior: *Real-time signals* (**SIGRTMIN** to **SIGRTMAX**). By default
R process reacts by shutting itself.

`signallR` changes this limited in usability process and allows to
intercept chosen *Real-time signal* and check if it have happened during
runtime of R process. Besides that, it also provides functions that
allow to send such signals to other processes on basis of their *pid*.

## Installation

You can install the development version of signallR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("StatisMike/signallR")
```

## SIGRT signals available

Number of UNIX signals available in system (including *Real-time
signals*) is not set in stone. To get information about what signals
could be used by processes on your machine, you can use one of the
provided functions:

``` r
library(signallR)
SIGRTs <- SIGRT_get()
# check the first 3 and last 3 SIGRT signals available on machine
SIGRTs[c(1:3, (nrow(SIGRTs)-3): nrow(SIGRTs)), ]
#>    nums    SIGRTMIN    SIGRTMAX
#> 1    34    SIGRTMIN SIGRTMAX-30
#> 2    35  SIGRTMIN+1 SIGRTMAX-29
#> 3    36  SIGRTMIN+2 SIGRTMAX-28
#> 28   61 SIGRTMIN+27  SIGRTMAX-3
#> 29   62 SIGRTMIN+28  SIGRTMAX-2
#> 30   63 SIGRTMIN+29  SIGRTMAX-1
#> 31   64 SIGRTMIN+30    SIGRTMAX
```

As you can see in above table, on machine I am rendering this *R
markdown* there are 31 *Real-time signals*. Their number (column `nums`)
can be potentially used to refer to them, but it is much safer to do it
by their codes beginning with **SIGRTMIN** (the first available signal)
and **SIGRTMAX** (the last available signal) and `+n` or `-n`.

## Intercepting *SIGRT* signals

Default behavior of `R` process upon receiving any of them is just
shutting down the process. It isn’t very useful, as it is just the same
as sending it **SIGTERM** or, even more brutally, **SIGKILL**.
`signallR` provides handlers to overwrite this default handler, and
instead count the number of received signals of specified type.

``` r
# began listening to the signal
SIGRT_listen("SIGRTMIN")
#> Precompiled handler for signal 'SIGRTMIN' have been registered.
#> [1] TRUE

# check how many signals have been received
SIGRT_check("SIGRTMIN")
#> [1] 0
```

As predicted, no **SIGRTMIN** signals have been received yet. They could
be send by external processes - eg. `C` programs running in parallel,
some supervising applications or - other `R` processes, using another
functions provided by `signallR`

## Sending *SIGRT* signals.

By default, *signal* sending isn’t vastly supported by `R`. You can
(with varying success) use `system()` function to send signals with
`kill` command. `signallR` provides a way to send signal to process on
basis of their **pid**

``` r
# without specifying PID, the signal will be sent to current process
SIGRT_send("SIGRTMIN")
#> [1] TRUE

# we can now check if this have been intercepted
SIGRT_check("SIGRTMIN")
#> [1] 1

# by default the count is not turned to zero - we can force this behaviour
SIGRT_check("SIGRTMIN", refresh = TRUE)
#> [1] 1
SIGRT_check("SIGRTMIN")
#> [1] 0
```

## WIP
