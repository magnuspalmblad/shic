#!/usr/bin/sh
mapfile -t myShims < <(grep -oP "(?<=shims/).*\.sh" shims.md)
${myShims[(($1-1))]} $2 $3
