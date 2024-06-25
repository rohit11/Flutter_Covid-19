```
#!/bin/bash

# Replace these variables with your own values
ARTIFACTORY_URL='https://repo1.uhc.com/artifactory'
REPO='npm-local/@optum-fpc/fpc/-/@optum-fpc'
FOLDER_PATH=''  # Leave empty if no additional folder path is needed

# Full URL to the folder
FULL_URL="$ARTIFACTORY_URL/$REPO/$FOLDER_PATH"

# Fetch HTML content from the repository URL
html_content=$(curl -s "$FULL_URL")

# Check if HTML content is empty
if [ -z "$html_content" ]; then
  echo "Error: Failed to retrieve HTML content from $FULL_URL"
  exit 1
fi

# Extract .tgz files and their associated metadata (Last-Modified and size)
files_and_metadata=$(echo "$html_content" | grep -o '<a href="[^"]*\.tgz"[^>]*>[^<]*</a>[^<]*')

# Variables to store the latest file and date
latest_file=""
latest_date=0

# Process each file and its associated metadata
while read -r line; do
  # Extract filename and metadata
  filename=$(echo "$line" | grep -o '[^/]*\.tgz')
  metadata=$(echo "$line" | sed -e 's/.*<\/a>//')
  
  # Extract Last-Modified date and size from metadata
  last_modified=$(echo "$metadata" | grep -o '[0-9]\{2\}-[A-Za-z]\{3\}-[0-9]\{4\} [0-9]\{2\}:[0-9]\{2\}')
  
  if [ -n "$filename" ] && [ -n "$last_modified" ]; then
    # Parse Last-Modified date into Unix timestamp
    file_date=$(date -jf "%d-%b-%Y %H:%M" "$last_modified" "+%s" 2>/dev/null || date -d "$last_modified" "+%s" 2>/dev/null)
    
    if [ -z "$file_date" ]; then
      echo "Warning: Failed to parse Last-Modified date for file $filename"
      continue
    fi
    
    # Compare and find the latest file
    if [ "$file_date" -gt "$latest_date" ]; then
      latest_date=$file_date
      latest_file=$filename
    fi
  fi
done <<< "$files_and_metadata"

if [ -n "$latest_file" ]; then
  # Extract version from latest_file
  version=$(echo "$latest_file" | sed -e 's/^fpcpsxnative-//' -e 's/\.tgz$//')
  echo "The latest version is: $version"
else
  echo "No recent .tgz files found."
fi


```
