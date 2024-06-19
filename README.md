# Flutter_Covid-19

# Sample

```
#!/bin/bash

# Function to update the main version in a package.json file
update_package_version() {
    local VERSION_NAME=$1
    local PACKAGE_JSON_PATH=$2
    jq --arg newVersion "$VERSION_NAME" '.version = $newVersion' "$PACKAGE_JSON_PATH" > temp.json && mv temp.json "$PACKAGE_JSON_PATH"
    echo "Updated version to $VERSION_NAME in $PACKAGE_JSON_PATH"
}

# Function to update a specific dependency version in a package.json file
# Function to update a specific dependency version in a package.json file
update_dependency_version() {
    local PACKAGE_JSON_PATH=$1
    local DEP_NAME=$2
    local DEP_VERSION=$3
    jq --arg depVersion "$DEP_VERSION" --arg depName "$DEP_NAME" '
        .dependencies |=
            if has($depName) then
                .[$depName] = $depVersion
            else
                . + {($depName): $depVersion}
            end
    ' "$PACKAGE_JSON_PATH" > temp.json && mv temp.json "$PACKAGE_JSON_PATH"
    echo "Updated dependency $DEP_NAME version to $DEP_VERSION in $PACKAGE_JSON_PATH"
}

# Function to create a new branch
create_git_branch() {
    local BRANCH_NAME=$1
    git checkout -b "$BRANCH_NAME" 2>/dev/null || git checkout "$BRANCH_NAME"
    echo "Created or switched to branch '$BRANCH_NAME' locally."
}

# Function to run yarn install in the specified directory
run_yarn_install() {
    local ROOT_DIR=$1
    (cd "$ROOT_DIR" && yarn install) || { echo "Failed to install dependencies in $ROOT_DIR"; exit 1; }
    echo "Installed dependencies in $ROOT_DIR"
}

# Prompt for root directory path
read -p "Enter the root directory path of the project: " ROOT_DIR

# Paths to package.json files relative to the root directory
PACKAGE_JSON_PATH_ARCADE="$ROOT_DIR/packages/arcade/package.json"
PACKAGE_JSON_PATH_GUIDED_SEARCH="$ROOT_DIR/packages/guided-search/package.json"

# Validate the root directory and package.json paths
if [ ! -d "$ROOT_DIR" ] || [ ! -f "$PACKAGE_JSON_PATH_ARCADE" ] || [ ! -f "$PACKAGE_JSON_PATH_GUIDED_SEARCH" ]; then
    echo "Error: Invalid root directory or package.json paths."
    exit 1
fi

# Get current month in lowercase (e.g., "june")
MONTH=$(date +"%B" | awk '{print tolower($0)}')

# Get current date
DATE=$(date +"%d")

# Remove leading zero from date, if any
DATE=$(echo $DATE | sed 's/^0*//')

# Branch name format: psx/{month}-{date}
BRANCH_NAME="psx/${MONTH}-${DATE}"

# Create a new branch with automatic name
(cd "$ROOT_DIR" && create_git_branch "$BRANCH_NAME")

# Prompt for new version name
read -p "Enter new version name: " VERSION_NAME

# Prompt for new dependency version
read -p "Enter new dependency version for @optum-fpc-psx-mobile-app/fpcpsxnative: " DEP_VERSION

# Update the main version in packages/arcade/package.json
update_package_version "$VERSION_NAME" "$PACKAGE_JSON_PATH_ARCADE"

# Update the dependency version in the package.json files
DEP_NAME="@optum-fpc-psx-mobile-app/fpcpsxnative"
update_dependency_version "$PACKAGE_JSON_PATH_ARCADE" "$DEP_NAME" "$DEP_VERSION"
update_dependency_version "$PACKAGE_JSON_PATH_GUIDED_SEARCH" "$DEP_NAME" "$DEP_VERSION"

# Run yarn install at the root directory
run_yarn_install "$ROOT_DIR"
```
