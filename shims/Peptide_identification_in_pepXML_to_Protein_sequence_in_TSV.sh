#!/bin/bash
xmllint --xpath "//*[local-name()='search_hit'][@hit_rank = '"1"']/@peptide" $1 | cut -d '"' -f2 > $2
