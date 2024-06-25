```
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
files_and_metadata=$(echo "$html_content" | grep -o '<a href="[^"]*\.tgz"[^>]*>[^<]*</a>' | sed -e 's/<a href="//' -e 's/">.*//')

# Variables to store the latest file and date
latest_file=""
latest_date=0

# Process each file and its associated metadata
while read -r line; do
  # Extract filename, Last-Modified date, and size
  filename=$(echo "$line" | grep -o '[^/]*\.tgz')
  metadata=$(echo "$line" | sed -e 's/.*>\([^<]*\)<\/a>/\1/')
  
  # Extract Last-Modified date from metadata (assuming format like "17-Jun-2024 06:03")
  last_modified=$(echo "$metadata" | grep -o '^[^ ]* [0-9]*, [0-9]* [0-9]*:[0-9]*')

  if [ -n "$filename" ] && [ -n "$last_modified" ]; then
    # Parse Last-Modified date into Unix timestamp
    file_date=$(date -jf "%d %b %Y %T %Z" "$last_modified" "+%s" 2>/dev/null || date -d "$last_modified" "+%s" 2>/dev/null)
    
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
  # Strip the prefix and suffix from the latest file name
  version=$(echo "$latest_file" | sed -e 's/^fpcpsxnative-//' -e 's/\.tgz$//')
  echo "The latest version is: $version"
else
  echo "No recent .tgz files found."
fi

```
