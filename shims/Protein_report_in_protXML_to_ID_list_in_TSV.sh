#!/bin/bash
xmllint --xpath "//*[local-name()='protein']/@protein_name" $1 | cut -d '|' -f2 > $2
