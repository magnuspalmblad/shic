| input type | input format | operation  | output type  | output format | bash | comment
|---|---|---|---|---|---|---|
| Protein report (http://edamontology.org/data_0896) | protXML (http://edamontology.org/format_3747) | Conversion (http://edamontology.org/operation_3434) | ID list (http://edamontology.org/data_2872) | TSV (http://edamontology.org/format_3475) | #!/bin/bash<br />xmllint --xpath "//*[local-name()='protein']/@protein_name" $1 \| cut -d '\|' -f2 > $2 | assumes UniProt style FASTA was used |
