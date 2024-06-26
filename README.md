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

# Variables to store the latest file and date
latest_version=""
latest_date=0

# Extract lines with .tgz filenames and their dates
files_and_metadata=$(echo "$html_content" | grep -o '<a href="[^"]*\.tgz"[^>]*>[^<]*</a>[^<]*')

# Process each file and its associated metadata
while IFS= read -r line; do
  # Extract filename from the <a> tag content
  filename=$(echo "$line" | sed -n 's/.*href="\([^"]*\)".*/\1/p')
  metadata=$(echo "$line" | sed -n 's/.*<\/a>\s*\(.*\)/\1/p')
  
  # Extract Last-Modified date from metadata (e.g., '25-Jun-2024 19:03')
  last_modified=$(echo "$metadata" | grep -o '[0-9]\{2\}-[A-Za-z]\{3\}-[0-9]\{4\} [0-9]\{2\}:[0-9]\{2\}')
  
  # Skip if we can't find a valid date
  if [ -z "$last_modified" ]; then
    echo "Warning: Failed to parse Last-Modified date for file $filename"
    continue
  fi

  # Parse Last-Modified date into Unix timestamp
  file_date=$(date -jf "%d-%b-%Y %H:%M" "$last_modified" "+%s" 2>/dev/null || date -d "$last_modified" "+%s" 2>/dev/null)

  # Skip if we fail to parse date
  if [ -z "$file_date" ]; then
    echo "Warning: Failed to convert Last-Modified date to timestamp for file $filename"
    continue
  fi

  # Extract version from filename
  version=$(echo "$filename" | sed -e 's/^.*fpcpsxnative-//' -e 's/\.tgz$//')

  # Compare and find the latest file based on date
  if [ "$file_date" -gt "$latest_date" ]; then
    latest_date=$file_date
    latest_version=$version
  fi
done <<< "$files_and_metadata"

if [ -n "$latest_version" ]; then
  echo "The latest version is: $latest_version"
else
  echo "No recent .tgz files found."
fi




```
