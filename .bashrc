# Include time so that it's easy to figure out when a command started and finished.
PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
