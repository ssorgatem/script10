#!/bin/bash

for a in 1 2 3 4 5 6 9 10 11 12 13 14 15 16 21 22 23; do
	./$1 rubisco seq*7  --transl_table $a
done
