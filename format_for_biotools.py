import re
import json

# Define a function to get the bio.tools term term and URI
def get_term_uri(cell) -> dict:
    json_data = {}
    json_data['uri'] = cell['uri']
    json_data['term'] = cell['term']
    return json_data
     
# Define a function to get the data type and format from the given cells
def get_data_format(cell_type, cell_format) -> list:
        # Define the data type for input
        json_format = []
        json_format.append(get_term_uri(cell_format))

        input = {}
        input['data'] = get_term_uri(cell_type)
        input['format'] = json_format

        inputs = []
        inputs.append(input)
        return inputs

def generate_biotools_json(shims_path):
    # Load content from the shims.md file
    with open(shims_path, 'r') as file:
        markdown_table = file.read()



    # Extract rows from the markdown table
    rows = re.findall(r'\|.*\|', markdown_table)


    # Define a list to store the extracted data
    functions_table = []

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


    # # Print the extracted data
    # for function_row in functions_table:
    #     print(function_row)

    json_functions = []
    # Generate JSON from the extracted data
    for function_row in functions_table[2:]:
        # Define the JSON structure for the current function
        json_function = {}


        
        json_function['input'] = get_data_format(function_row[0], function_row[1])
        json_function['output'] = get_data_format(function_row[3], function_row[4])
        operation = []
        operation.append(get_term_uri(function_row[2]))
        json_function['operation'] = operation
        json_functions.append(json_function)

    json_string = json.dumps(json_functions, indent=4)  # Use indent for pretty formatting
    return json_string


    
    
# Call the function to generate the JSON
json_string = generate_biotools_json('shims.md')

# Print the generated JSON
with open('assets/functions.json', 'w') as f: f.write(json_string)

# Get the latest version of the 'shic' JSON schema from
#TODO

# Combine the functions and the schema
#TODO

# Push the combined JSON to the bio.tools repository
#TODO