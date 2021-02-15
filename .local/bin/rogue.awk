#!/bin/awk -f
#
# rogue.awk - Find files that are not accounted for
#
# Rogue is called from a cron job on an hourly basis.
# It parses files in the filesystem and checks to see
# that they belong to an rpm.  Then it prints the
# output of rpm -Va to verify those files that do
# belong to an rpm.
#
BEGIN {
  # Required commands
  cmd1="/bin/rpm -qal";
# -path '/misc' -prune -o -path '/net' -prune -o -path '/proc' -prune -o -path '/selinux' -prune -o -path '/sys' -prune -o 
  cmd2="find / -xdev -path '/home' -prune -o -path '/var/log' -prune -o -path '/dev' -prune -o -path '/cgroup' -prune -o -print";
 
  # All rpms in rpm db
  while ( cmd1 | getline ) {
    rpmfiles[$0] = 1;
  }
  close(cmd1);
 
  # All files on system not in an rpm
  while ( cmd2 | getline ) {
    if (!($0 in rpmfiles)) {
      orphans[$0] = 1;
    }
  }
  close(cmd2);
  delete rpmfiles;
  exit 0; # hit 'END' right now
}
END {
  for (file in orphans) {
    print "R:orphaned",file | "sort"
  }
  while ("rpm -Va --noghost" | getline) {
    print "R:" $0 | "sort"
  }
}
