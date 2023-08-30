#!/bin/bash
grep -oP '[pr]\|\K.{6}' $1 > $2
