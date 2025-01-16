#!/bin/bash
xmllint --xpath "//*[local-name()='search_hit'][@hit_rank = '"1"']/@protein_descr" $1 | cut -d '"' -f2 | awk '{gsub("OS=.+$",""); print}' > $2
