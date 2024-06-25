```
# Full URL to the folder
FULL_URL="$ARTIFACTORY_URL/$REPO/$FOLDER_PATH"

# Get the list of .tgz files from the HTML page
files=$(curl -s "$FULL_URL" | grep -o '<a href="[^"]*\.tgz"' | sed -e 's/<a href="//' -e 's/"//')

# Calculate current date in Unix timestamp
current_date=$(date "+%s")

# Start of last 1 day in Unix timestamp (24 hours ago)
one_day_ago=$(date -v -1d "+%s" 2>/dev/null || date -d '1 day ago' "+%s" 2>/dev/null)

# Variables to store the latest file and date
latest_file=""
latest_date=0

# Function to parse Last-Modified date into Unix timestamp
parse_last_modified() {
  local file_url="$1"
  local last_modified
  last_modified=$(curl -sI "$file_url" | grep -i 'last-modified' | sed 's/Last-Modified: //I')
  
  if [ -z "$last_modified" ]; then
    echo "Warning: Failed to retrieve Last-Modified date for file $file_url"
    return 1
  fi
  
  local file_date
  file_date=$(date -jf "%a, %d %b %Y %T %Z" "$last_modified" "+%s" 2>/dev/null || date -d "$last_modified" "+%s" 2>/dev/null)
  
  if [ -z "$file_date" ]; then
    echo "Warning: Failed to parse Last-Modified date for file $file_url"
    return 1
  fi
  
  echo "$file_date"
}

# Process each file extracted from html_page
for file in $files; do
  # Construct full URL for the file
  file_url="$FULL_URL/$file"

  # Get the Last-Modified date of the file
  file_date=$(parse_last_modified "$file_url")

  if [ $? -ne 0 ]; then
    continue
  fi

  # Only consider files modified within the last 24 hours
  if [ "$file_date" -ge "$one_day_ago" ] && [ "$file_date" -le "$current_date" ]; then
    # Compare and find the latest file
    if [ "$file_date" -gt "$latest_date" ]; then
      latest_date=$file_date
      latest_file=$file
    fi
  fi
done

if [ -n "$latest_file" ]; then
  # Strip the prefix and suffix from the latest file name
  version=$(echo "$latest_file" | sed -e 's/^fpcpsxnative-//' -e 's/\.tgz$//')
  echo "The latest version is: $version"
else
  echo "No recent .tgz files found."
fi
```
