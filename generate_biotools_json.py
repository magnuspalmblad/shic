import re
import json
from typing import List, Dict

# Define the column numbers for the input and output data type and format
input_type_column = 0
""" Column for input data type. """
input_format_column = 1
""" Column for input data format. """
operation_column = 2
""" Column for operation. """
output_type_column = 3
""" Column for output data type. """
output_format_column = 4
""" Column for output data format. """
rows_to_skip = 2
""" Number of rows to skip at the start of the table. """


def get_term_uri(cell) -> Dict[str, str]:
    """
    Extract the term and URI from the given cell, and return a dictionary containing the term and URI.

    :param cell: The cell to extract the term and URI from
    :return: A dictionary containing the term and URI
    """
    json_data = {}
    json_data['uri'] = cell['uri']
    json_data['term'] = cell['term']
    return json_data
     
def get_data_format(cell_type, cell_format) -> List[dict]:
    """
    Extract the data type and format from the given cells, and return a list containing one element describing the data type and format
    :param cell_type: The cell containing the data type
    :param cell_format: The cell containing the data format
    :return: A list containing one element describing the data type and format
    """
    # Define the data type for input
    json_format = []
    json_format.append(get_term_uri(cell_format))

    data_pair = {}
    data_pair['data'] = get_term_uri(cell_type)
    data_pair['format'] = json_format

    inputs = []
    inputs.append(data_pair)
    return inputs

def read_shims_md(shims_path) -> List[List[dict]]:
    """
    Read the shims.md file and extract the data from the table into a list of lists (rows and columns).
    :param shims_path: The path to the shims.md file.
    :return: A list of lists (rows and columns) containing the extracted data table.
    """

     # Load content from the shims.md file
    with open(shims_path, 'r') as file:
        markdown_table = file.read()

    # Extract rows from the markdown table
    rows = re.findall(r'\|.*\|', markdown_table)

    # Define a list to store the extracted data
    functions_table = []

    # Loop through each row and extract fields
    for row in rows:
        cells = row.split('|')[1:-1]  # Remove the empty cells at the start and end
        extracted_cells = []
        for cell in cells:
            cell = cell.strip()
            match = re.match(r'\[(.*?)\]\((.*?)\)', cell)
            if match:
                description, link = match.groups()
                extracted_cells.append({'term': description, 'uri': link})
            else:
                extracted_cells.append({'plain_content': cell})
        functions_table.append(extracted_cells)

    return functions_table


def generate_biotools_functions_json(shims_path) -> List[dict]:
    """
    Generate the JSON that represents bio.tools schema functions from the shims.md file.
    :param shims_path: The path to the shims.md file.
    :return: The generated JSON array of functions.
    """
    
    # Read the shims.md file and extract the data from the table
    functions_table = read_shims_md(shims_path)

    json_functions = []
    # Generate JSON from the extracted data
    for function_row in functions_table[rows_to_skip:]:
        # Define the JSON structure for the current function
        json_function = {}
        
        # Get inputs from the first 2 columns
        json_function['input'] = get_data_format(function_row[input_type_column], function_row[input_format_column])
        json_function['output'] = get_data_format(function_row[output_type_column], function_row[output_format_column])
        operation = []
        operation.append(get_term_uri(function_row[operation_column]))

        json_function['operation'] = operation
        json_functions.append(json_function)

    return json_functions


    

# Call the function to generate the JSON
json_functions = generate_biotools_functions_json('shims.md')

# Print the generated JSON - for debugging
json_string = json.dumps(json_functions, indent=4)  # Use indent for pretty formatting
with open('assets/functions.json', 'w') as f: f.write(json_string)

# Get the latest version of the 'shic' JSON schema from bio.tools
#TODO


# Substitute the functions in the JSON schema with the newly generated JSON functions (json_functions)
#TODO

# Push the combined JSON to the bio.tools repository
#TODO