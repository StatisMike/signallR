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

