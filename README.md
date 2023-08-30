<img src="/assets/img/shic_logo.png" alt="shic logo" style="height: 250px;"/>

# shic
shic is a collection of shims for use in automated workflow composition

Shims are here understood as being small pieces of glue code to gently massage, or shim, data produced by one software to data expected by another. Semantically they are format converters, although their inputs and outputs could be different dialects or interpretations of the same format.

The shims are contained in the [shims](shims) folder.

The [shims.md](shims.md) table contains minimum metadata for all shims, including [EDAM](https://edamontology.org/) data type and format for the shim input and output (the operation typically being [Conversion](https://edamontology.org/), the [domain](http://edamontology.org/topic_0003) and intended use.

shic is developed as part of the [Workflomics](https://research-software-directory.org/software/workflomics) project.

# Notes for developers

The [shims.md](shims.md) table is automatically parsed to generate the [shic bio.tools entry](https://bio.tools/shic). Changing its format (columns, column names, EDAM references, etc.) may require corresponding changes to the parser.
