<img src="/assets/img/shic_logo.png" alt="shic logo" style="height: 250px;"/>

# shic
shic is a collection of shims for (automated) workflow composition and general utility too small or too trivial to warrant their own repository or entry in software registries.

_What is a "shim"?_

In our interpretation (not to be confused with the one in [Wikipedia](https://en.wikipedia.org/wiki/Shim_(computing)), a shim is a short code fragment that fills the gaps when creating a data processing workflow from separate software tools. Here a shim then can be a few lines of code that extract the necessary information from a more complex file, converts between similar but not identical file types, or adds redundant information to fill input requirements. In other words, shims are here understood as being small pieces of glue code to gently massage, or shim, data produced by one software into data expected by another. Semantically they are format converters, although their inputs and outputs may be different dialects or interpretations of the same format rather than different formats. The shims are generally dependent on the data type and application domain.

The shims are contained in the [shims folder](shims) as simple script files (bash, Python or others).

For a coarse but standardized description of the functionality, we rely on the [EDAM ontology](edamontology.github.io/). The [shims.md table](shims.md) contains minimum metadata for all shims, including EDAM data type and format for the shim input and output, the operation (typically [Conversion](http://edamontology.org/operation_3434)), [domain](http://edamontology.org/topic_0003) and intended use.

shic is developed to support the [Workflomics](https://research-software-directory.org/software/workflomics) project on automated workflow exploration and benchmarking.

# Notes for developers

[shims.md](shims.md) is automatically parsed to generate the [shic bio.tools entry](https://bio.tools/shic). Changing its format (non-table content, columns, column names, EDAM references, etc.) may require corresponding changes to the parser.

Tools such as [awk](https://usegalaxy.eu/root?tool_id=toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2), [cut](https://usegalaxy.eu/root?tool_id=Cut1), [grep](https://usegalaxy.eu/root?tool_id=toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1) and [XPath](https://usegalaxy.eu/root?tool_id=toolshed.g2.bx.psu.edu/repos/iuc/xpath/xpath/1.0.0) used by these shims are available on common [UseGalaxy servers](https://galaxyproject.org/use/), and can be used to implement many of these shims directly in Galaxy workflows.

# Updating the bio.tools [entry](https://bio.tools/shic)

The script [generate_biotools_json.py](generate_biotools_json.py) is used to compile the complete bio.tools JSON entry based on the metadata in the [shims.md](shims.md) table. Currently, users should manually upload the content of [assets/bio.tools_entry.json](https://github.com/magnuspalmblad/shic/blob/main/assets/bio.tools_entry.json) to the [shic entry in bio.tools](https://bio.tools/shic/edit) using "Update this record" -> "JSON" or the bio.tools API. In the future, this will be automated as a GitHub action using bio.tools API.

