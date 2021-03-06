% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SIGRT_check.R
\name{SIGRT_listen}
\alias{SIGRT_listen}
\title{Began listening for SIGRT signal}
\usage{
SIGRT_listen(signal)
}
\arguments{
\item{signal}{Valid UNIX SIGRT signal to listen for. Either its integer value
or name beginning with "SIGRTMIN" or "SIGRTMAX".}
}
\value{
boolean indicating if initializing procedure have been completed.
\code{FALSE} means that the listening procedure have been intialized before
}
\description{
Before running checks for particular signal, it is mandatory to first call
this function - it installs the custom handler for specified signal.

As available SIGRT signals vary from system to system, you can check the
list of available signals with \code{\link[=SIGRT_get]{SIGRT_get()}}.

Five slots for SIGRT signals to listen for are precompiled. To use more than
five, \code{inline} package needs to be installed in the system.
}
\examples{
# Begin listening for signal SIGRTMIN+1 and SIGRTMAX-3
SIGRT_listen("SIGRTMIN+1")
SIGRT_listen("SIGRTMAX-3")

# Check if there were no signals received
SIGRT_check("SIGRTMIN+1")
SIGRT_check("SIGRTMAX-3")

# Send some signals to itself
for (i in 1:4)
  SIGRT_send("SIGRTMIN+1")
for (i in 1:2)
  SIGRT_send("SIGRTMAX-3")

# Check if correct number of signals were received
SIGRT_check("SIGRTMIN+1")

# refresh flag for SIGRTMAX-3
SIGRT_check("SIGRTMAX-3", refresh = T)
SIGRT_check("SIGRTMAX-3")

}
