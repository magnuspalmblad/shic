#!/bin/bash
xmllint --xpath "//*[local-name()='uri']/text()" $1 | grep -oP "CHEBI.+" | sed 's/_/:/' $2
