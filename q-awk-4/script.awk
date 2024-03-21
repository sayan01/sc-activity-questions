#!/usr/bin/gawk -f

BEGIN{
    FPAT="([^" FS "]+" FS "){" N-1 "}" "[^" FS "]+"
}

{
  for (i=1; i<=NF; i++) {
    print $i
  }
}
