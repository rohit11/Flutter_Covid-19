```
#!/bin/bash

# Replace these variables with your own values
ARTIFACTORY_URL='https://repo1.uhc.com/artifactory'
REPO='npm-local/@optum-fpc/fpc/-/@optum-fpc'
FOLDER_PATH=''  # Leave empty if no additional folder path is needed

# Full URL to the folder
FULL_URL="$ARTIFACTORY_URL/$REPO/$FOLDER_PATH"

# Fetch HTML content from the repository URL and extract .tgz files
files_and_metadata=$(curl -s "$FULL_URL" | grep -o '<a[^>]*>[^<]*</a>[^<]*')

# Variables to store the latest file and date
latest_file=""
latest_date=0

# Process each file and its associated metadata
while read -r line; do
  # Extract filename from the <a> tag content
  filename=$(echo "$line" | sed -e 's/<[^>]*>//g')

  if [[ "$filename" == *.tgz ]]; then
    # Extract version from filename
    version=$(echo "$filename" | sed -e 's/^fpcpsxnative-//' -e 's/\.tgz$//')
    
    if [ -z "$version" ]; then
      echo "Warning: Failed to extract version from filename $filename"
      continue
    fi
    
    # Extract Last-Modified date and size from metadata (if needed)
    # Example: last_modified=$(echo "$line" | grep -o '[0-9]\{2\}-[A-Za-z]\{3\}-[0-9]\{4\} [0-9]\{2\}:[0-9]\{2\}')
    
    # For simplicity, assume the latest is determined by filename timestamp or other criteria
    
    # Here, you might add logic to compare dates or other criteria to find the latest file
    
    # For illustration, we assume the latest file based on the filename comparison
    latest_file="$version"
  fi
done <<< "$files_and_metadata"

if [ -n "$latest_file" ]; then
  echo "The latest version is: $latest_file"
else
  echo "No recent .tgz files found."
fi




```
