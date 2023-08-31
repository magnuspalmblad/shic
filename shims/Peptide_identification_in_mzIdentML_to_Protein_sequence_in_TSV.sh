#!/bin/bash
xmllint --xpath "//*[local-name()='PeptideSequence']/text()" $1 > $2
