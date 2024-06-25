```
#!/bin/bash

#!/bin/bash

# Replace these variables with your own values
ARTIFACTORY_URL='https://repo1.uhc.com/artifactory'
REPO='npm-local/@optum-fpc/fpc/-/@optum-fpc'
FOLDER_PATH=''  # Leave empty if no additional folder path is needed

# Full URL to the folder
FULL_URL="$ARTIFACTORY_URL/$REPO/$FOLDER_PATH"

# Fetch HTML content from the repository URL and extract .tgz files
files_and_metadata=$(curl -s "$FULL_URL" | grep -o '<a href="[^"]*\.tgz"[^>]*>[^<]*</a>[^<]*')

# Variables to store the latest file and date
latest_file=""
latest_date=0

# Process each file and its associated metadata
while read -r line; do
  # Extract filename
  filename=$(echo "$line" | grep -o '[^/]*\.tgz')

  if [ -n "$filename" ]; then
    # Extract version from filename
    version=$(echo "$filename" | sed -e 's/^fpcpsxnative-//' -e 's/\.tgz$//')
    
    # Extract Last-Modified date and size from metadata
    metadata=$(echo "$line" | sed -e 's/.*<\/a>//')
    last_modified=$(echo "$metadata" | grep -o '[0-9]\{2\}-[A-Za-z]\{3\}-[0-9]\{4\} [0-9]\{2\}:[0-9]\{2\}')
    
    if [ -z "$last_modified" ]; then
      echo "Warning: No Last-Modified date found for file $filename"
      continue
    fi
    
    # Parse Last-Modified date into Unix timestamp
    file_date=$(date -jf "%d-%b-%Y %H:%M" "$last_modified" "+%s" 2>/dev/null || date -d "$last_modified" "+%s" 2>/dev/null)
    
    if [ -z "$file_date" ]; then
      echo "Warning: Failed to parse Last-Modified date for file $filename"
      continue
    fi
    
    # Compare and find the latest file
    if [ "$file_date" -gt "$latest_date" ]; then
      latest_date=$file_date
      latest_file=$version  # Store just the version number
    fi
  fi
done <<< "$files_and_metadata"

if [ -n "$latest_file" ]; then
  echo "The latest version is: $latest_file"
else
  echo "No recent .tgz files found."
fi


```
