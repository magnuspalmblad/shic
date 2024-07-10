<img src="/assets/img/shic_logo.png" alt="shic logo" style="height: 250px;"/>

# shic
[![bio.tools annotations](https://github.com/magnuspalmblad/shic/actions/workflows/bio.tools.yml/badge.svg)](https://github.com/magnuspalmblad/shic/actions/workflows/bio.tools.yml)
[![GitHub license](https://img.shields.io/github/license/magnuspalmblad/shic)](https://github.com/magnuspalmblad/shic/blob/main/LICENSE)

shic is a collection of shims for (automated) workflow composition and general utility too small or too trivial to warrant their own repository or entry in software registries.

_What is a "shim"?_

In our interpretation (not to be confused with the one in [Wikipedia](https://en.wikipedia.org/wiki/Shim_(computing))), a shim is a short code fragment that fills the gaps when creating a data processing workflow from separate software tools. Here a shim can be a few lines of code that extract the necessary information from a more complex file, convert between similar but not identical file types, or add redundant information to fill input requirements. In other words, shims are understood as being small pieces of glue code to gently massage, or shim, data produced by one software into data expected by another. Semantically, most shims are [format converters](http://edamontology.org/operation_3434), although their inputs and outputs may be different dialects or interpretations of the same format rather than different formats. The shims are generally dependent on the data type and application domain.

For technical reasons, including automatic annotation in [bio.tools](https://bio.tools) and simplifying the master shim interface to the shim collection, we only includes those shims that take a single file as input and outputs a single file.

The shims are contained in the [shims folder](shims) as simple executable scripts in bash, Python or others scripting language.

For a coarse but standardized description of the functionality, we rely on the [EDAM ontology](https://edamontology.org). The [shims.md table](shims.md) contains minimum metadata for all shims, including EDAM data type and format for the shim input and output, the operation (typically [Conversion](http://edamontology.org/operation_3434)), [domain](http://edamontology.org/topic_0003) and intended use.

shic is developed to support the [Workflomics](https://research-software-directory.org/software/workflomics) project on automated workflow exploration and benchmarking.

# Notes for curators and developers

[shims.md](shims.md) is automatically parsed to generate the [shic bio.tools entry](https://bio.tools/shic). Changing its format (non-table content, columns, column names, EDAM references, etc.) may require corresponding changes to the parser.

N.B. The [Workflomics](https://research-software-directory.org/software/workflomics) project enumerates the shims. Append new shims to the bottom of the table. If a shim is obsolete or deprecated, do not remove it, but remove its inputs and outputs, to avoid having APE explore workflows with this particular shim. All shims can be executed by calling masterShim.sh with the ID (number) of the shim and the arguments (input and output filenames) to the shim.

Tools such as [awk](https://usegalaxy.eu/root?tool_id=toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2), [cut](https://usegalaxy.eu/root?tool_id=Cut1), [grep](https://usegalaxy.eu/root?tool_id=toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1) and [XPath](https://usegalaxy.eu/root?tool_id=toolshed.g2.bx.psu.edu/repos/iuc/xpath/xpath/1.0.0) used by these shims are available on common [UseGalaxy servers](https://galaxyproject.org/use/), and can be used to implement many of these shims directly in Galaxy workflows.

# Updating the [bio.tools entry](https://bio.tools/shic)

## Semi-automatic update

After each push to the `main` branch the new bio.tools annotation file is generated and available as an _Artifact_ in the [GitHub action](https://github.com/magnuspalmblad/shic/actions/workflows/bio.tools.yml). Step to update bio.tools `shic` entry:

1. Go to the [GitHub action](https://github.com/magnuspalmblad/shic/actions/workflows/bio.tools.yml).
2. Select the latest run, scroll to _Artifacts_ (at the bottom) and download the file.
3. Open the [shic entry in bio.tools](https://bio.tools/shic/edit) (you must be logged in as a maintainer of the tool in bio.tools to access the `/edit` screen).
4. Navigate to the `JSON` tab and paste the content of the downloaded file into the text box.
5. Click `Validate` to validate the JSON structure.
6. Click `Save` to update the entry.

## Local update

The script [generate_biotools_json.py](generate_biotools_json.py) is used to compile the complete bio.tools JSON entry based on the metadata in the [shims.md](shims.md) table. The user should manually upload the content of `assets/bio.tools_entry.json` to the [shic entry in bio.tools](https://bio.tools/shic/edit) using "Update this record" -> "JSON" or the bio.tools API (see steps 4-6 in the [Semi-automatic update](#semi-automatic-update) section).

