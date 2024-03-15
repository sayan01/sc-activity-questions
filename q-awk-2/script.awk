#!/usr/bin/gawk -f

BEGIN{
 FS=","
 OFMT="%.2f"
 OFS="\t"
}

{
  gsub(/"/, "", $6)
  gsub(/"/, "", $7)
  gsub(/"/, "", $8)
  math+=int($6)
  reading+=int($7)
  writing+=int($8)
  mean=(int($6)+int($7)+int($8))/3
  if($3 ~ /school/){
    parentschool++
    if(mean>=80){
      hmapnc++
    }
  } else {
    if(mean>=80){
      hmapc++
    }
  }
}

$1 ~ /female/ {
  female++
}

END{
  print "math average", math/NR
  print "read average", reading/NR
  print "write average", writing/NR
  print "female percent", female/NR*100
  print "male percent", (NR-female)/NR*100
  print "parent college%", (NR-parentschool)/NR*100
  print "P(>79|college)", (hmapc/(NR-parentschool))*100
  print "P(>79|~college)", (hmapnc/parentschool)*100
}
