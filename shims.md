| input type | input format | operation  | output type  | output format | shim | dependencies | comments
|---|---|---|---|---|---|---|---|
| [Protein report](http://edamontology.org/data_0896) | [protXML](http://edamontology.org/format_3747) | [Conversion](http://edamontology.org/operation_3434) | [ID list](http://edamontology.org/data_2872) | [TSV](http://edamontology.org/format_3475) | [Protein_report_in_protXML_to_ID_list_in_TSV.sh](shims/Protein_report_in_protXML_to_ID_list_in_TSV.sh) | xmllint | assumes UniProt style FASTA was used |
