| input type | input format | operation  | output type  | output format | bash | comment
|---|---|---|---|---|---|---|
| Protein report | protXML | Conversion | ID list | TSV | xmllint --xpath "//*[local-name()='protein']/@protein_name" input \| cut -d '\|' -f2 > output | assumes UniProt style FASTA was used |
