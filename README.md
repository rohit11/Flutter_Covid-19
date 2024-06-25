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

# Extract .tgz files and their Last-Modified dates directly from HTML content
files_and_dates=$(echo "$html_content" | grep -o '<a href="[^"]*\.tgz"[^>]*>[^<]*</a>' | sed -e 's/<a href="//' -e 's/">.*//')

# Calculate current date in Unix timestamp
current_date=$(date "+%s")

# Start of last 1 day in Unix timestamp (24 hours ago)
one_day_ago=$(date -v -1d "+%s" 2>/dev/null || date -d '1 day ago' "+%s" 2>/dev/null)

# Variables to store the latest file and date
latest_file=""
latest_date=0

# Process each file and its Last-Modified date
while read -r line; do
  # Extract filename and Last-Modified date
  filename=$(echo "$line" | grep -o '[^/]*\.tgz')
  last_modified=$(echo "$line" | sed -e 's/.*>\([^<]*\)<\/a>/\1/' | grep -o '[^,]*$')

  if [ -n "$filename" ] && [ -n "$last_modified" ]; then
    # Parse Last-Modified date into Unix timestamp
    file_date=$(date -jf "%d %b %Y %T %Z" "$last_modified" "+%s" 2>/dev/null || date -d "$last_modified" "+%s" 2>/dev/null)
    
    if [ -z "$file_date" ]; then
      echo "Warning: Failed to parse Last-Modified date for file $filename"
      continue
    fi
    
    # Only consider files modified within the last 24 hours
    if [ "$file_date" -ge "$one_day_ago" ] && [ "$file_date" -le "$current_date" ]; then
      # Compare and find the latest file
      if [ "$file_date" -gt "$latest_date" ]; then
        latest_date=$file_date
        latest_file=$filename
      fi
    fi
  fi
done <<< "$files_and_dates"

if [ -n "$latest_file" ]; then
  # Strip the prefix and suffix from the latest file name
  version=$(echo "$latest_file" | sed -e 's/^fpcpsxnative-//' -e 's/\.tgz$//')
  echo "The latest version is: $version"
else
  echo "No recent .tgz files found."
fi

```
