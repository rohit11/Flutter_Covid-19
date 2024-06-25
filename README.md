```
# Function to fetch the latest version of a package from Artifactory
fetch_latest_package_version() {
    local ARTIFACTORY_URL='https://repo1.uhc.com/artifactory'
    local REPO='npm-local/@optum-fpc/fpc/-/@optum-fpc'
    local FOLDER_PATH=''  # Leave empty if no additional folder path is needed

    # Full URL to the folder
    local FULL_URL="$ARTIFACTORY_URL/$REPO/$FOLDER_PATH"

    # Fetch HTML content from the repository URL and extract .tgz files
    local files_and_metadata=$(curl -s "$FULL_URL" | grep -o '<a href="[^"]*\.tgz"[^>]*>[^<]*</a>[^<]*')

    # Variables to store the latest file and date
    local latest_file=""
    local latest_date=0

    # Process each file and its associated metadata
    while read -r line; do
        # Extract filename and metadata
        local filename=$(echo "$line" | grep -o '[^/]*\.tgz')
        local metadata=$(echo "$line" | sed -e 's/.*<\/a>//')

        # Extract Last-Modified date and size from metadata
        local last_modified=$(echo "$metadata" | grep -o '[0-9]\{2\}-[A-Za-z]\{3\}-[0-9]\{4\} [0-9]\{2\}:[0-9]\{2\}')

        if [ -n "$filename" ] && [ -n "$last_modified" ]; then
            # Parse Last-Modified date into Unix timestamp
            local file_date=$(date -jf "%d-%b-%Y %H:%M" "$last_modified" "+%s" 2>/dev/null || date -d "$last_modified" "+%s" 2>/dev/null)

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
        local version=$(echo "$latest_file" | sed -e 's/^fpcpsxnative-//' -e 's/\.tgz$//' -e 's/.*-//')
        echo "$version"
    else
        echo ""
    fi
}

# Fetch the latest version automatically
DEP_VERSION=$(fetch_latest_package_version)

# Prompt to use or enter the dependency version
read -p "Do you want to use the latest version of @optum-fpc-psx-mobile-apps/fpcpsxnative from Artifactory? [Y/n] " USE_LATEST_VERSION

if [[ "$USE_LATEST_VERSION" =~ ^[Yy]$ ]] || [[ -z "$USE_LATEST_VERSION" ]]; then
    if [ -z "$DEP_VERSION" ]; then
        echo "Failed to fetch the latest version from Artifactory. Please enter the version manually."
        read -p "Enter new dependency version for @optum-fpc-psx-mobile-apps/fpcpsxnative: " DEP_VERSION
    else
        echo "Automatically detected latest version: $DEP_VERSION"
    fi
else
    # Manual entry of version
    read -p "Enter new dependency version for @optum-fpc-psx-mobile-apps/fpcpsxnative: " DEP_VERSION
fi

echo "Selected dependency version: $DEP_VERSION"

# Continue with your script logic using $DEP_VERSION
```

```
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
  # Extract filename and metadata
  filename=$(echo "$line" | grep -o '[^/]*\.tgz')
  metadata=$(echo "$line" | sed -e 's/.*<\/a>//')
  
  # Extract Last-Modified date and size from metadata
  last_modified=$(echo "$metadata" | grep -o '[0-9]\{2\}-[A-Za-z]\{3\}-[0-9]\{4\} [0-9]\{2\}:[0-9]\{2\}')
  
  if [ -n "$filename" ] && [ -n "$last_modified" ]; then
    # Parse Last-Modified date into Unix timestamp
    file_date=$(date -d "$last_modified" "+%s" 2>/dev/null)
    
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
  version=$(echo "$latest_file" | grep -oP '(?<=fpcpsxnative-)\d+\.\d+\.\d+')
  echo "The latest version is: $version"
else
  echo "No recent .tgz files found."
fi


```
