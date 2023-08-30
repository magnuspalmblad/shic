<img src="/assets/img/shic_logo.png" alt="shic logo" style="height: 250px;"/>

# shic
shic is a collection of shims for (automated) workflow composition and general utility too small or too trivial to warrant their own repository and [bio.tools](bio.tools) entry.

The shims are here understood as being small pieces of glue code to gently massage, or shim, data produced by one software into data expected by another. Semantically they are format converters, although their inputs and outputs could be different dialects or interpretations of the same format rather than different formats. The shims are generally dependent on the data type and application domain.

The shims are contained in the [shims folder](shims).

The [shims.md table](shims.md) contains minimum metadata for all shims, including [EDAM](https://edamontology.org/) data type and format for the shim input and output (the operation typically being [Conversion](https://edamontology.org/), the [domain](http://edamontology.org/topic_0003) and intended use.

shic is developed as part of the [Workflomics](https://research-software-directory.org/software/workflomics) project.

# Notes for developers

[shims.md](shims.md) is automatically parsed to generate the [shic bio.tools entry](https://bio.tools/shic). Changing its format (non-table content, columns, column names, EDAM references, etc.) may require corresponding changes to the parser.

Tools such as [awk](https://usegalaxy.eu/root?tool_id=toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2), [cut](https://usegalaxy.eu/root?tool_id=Cut1), [grep](https://usegalaxy.eu/root?tool_id=toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1) and [XPath](https://usegalaxy.eu/root?tool_id=toolshed.g2.bx.psu.edu/repos/iuc/xpath/xpath/1.0.0) used by these shims are available on common [UseGalaxy servers](https://galaxyproject.org/use/), and can be used to implement many of these shims directly in Galaxy workflows.
