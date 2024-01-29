#!/usr/bin/sh
mapfile -t myShims < <(grep -oP "(?<=shims/).*\.sh" shims.md)
echo -n "Executing \""${myShims[(($1-1))]} $2 $3"\"..."
${myShims[(($1-1))]} $2 $3
echo "done"
