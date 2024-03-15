#!/usr/bin/gawk -f

BEGIN{
  OFS=" - "
}

$4 == YEAR && (($17 == "Major" && $15 >= 120) || ($18 > 80)) {
  print $1, $2
}
