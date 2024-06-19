# Flutter_Covid-19

# Sample

```
#!/bin/bash

# Function to update the main version in a package.json file
update_package_version() {
    local PACKAGE_JSON_PATH=$1
    local MONTH=$2
    local DATE=$3

    # Read the current version from the package.json file
    CURRENT_VERSION=$(jq -r '.version' "$PACKAGE_JSON_PATH")

    # Replace everything after the last '-' with the new suffix
    BASE_VERSION=$(echo "$CURRENT_VERSION" | sed 's/-.*$//')
    NEW_VERSION="${BASE_VERSION}-psx-main-${MONTH}-${DATE}"

    # Update the version in package.json
    jq --arg newVersion "$NEW_VERSION" '.version = $newVersion' "$PACKAGE_JSON_PATH" > temp.json && mv temp.json "$PACKAGE_JSON_PATH"
    echo "Updated version to $NEW_VERSION in $PACKAGE_JSON_PATH"
}

# Function to update a specific dependency version in a package.json file
update_dependency_version() {
    local PACKAGE_JSON_PATH=$1
    local DEP_NAME=$2
    local DEP_VERSION=$3
    jq --arg depVersion "$DEP_VERSION" --arg depName "$DEP_NAME" '
        if .dependencies[$depName] then
            .dependencies[$depName] = $depVersion
        else
            .dependencies += {($depName): $depVersion}
        end
    ' "$PACKAGE_JSON_PATH" > temp.json && mv temp.json "$PACKAGE_JSON_PATH"
    echo "Updated dependency $DEP_NAME version to $DEP_VERSION in $PACKAGE_JSON_PATH"
}

# Function to create a new branch from the development branch
create_new_branch_from_development() {
    local BRANCH_NAME=$1
    git checkout development || { echo "Failed to switch to development branch."; exit 1; }
    git checkout -b "$BRANCH_NAME" development || { echo "Failed to create new branch '$BRANCH_NAME'."; exit 1; }
    echo "Created and switched to new branch '$BRANCH_NAME' from 'development'"
}

# Function to run yarn install in the specified directory
run_yarn_install() {
    local ROOT_DIR=$1
    (cd "$ROOT_DIR" && yarn install) || { echo "Failed to install dependencies in $ROOT_DIR"; exit 1; }
    echo "Installed dependencies in $ROOT_DIR"
}

# Function to commit changes to Git
commit_changes() {
    local ROOT_DIR=$1
    local COMMIT_MESSAGE=$2
    cd "$ROOT_DIR" || { echo "Failed to change directory to $ROOT_DIR"; exit 1; }

    # Add all modified files to staging area
    git add -A

    # Display changes for each modified file
    local MODIFIED_FILES=$(git diff --cached --name-only)
    if [ -z "$MODIFIED_FILES" ]; then
        echo "No changes to commit."
        return
    fi

    echo "Modified files:"
    for file in $MODIFIED_FILES; do
        echo "File: $file"
        git --no-pager diff --cached -- "$file"
        echo ""
    done

    # Prompt for confirmation
    read -r -p "Are you sure you want to commit these changes? [y/N] " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        git commit -m "$COMMIT_MESSAGE" || { echo "Failed to commit changes."; exit 1; }
        echo "Committed changes to Git with message: $COMMIT_MESSAGE"
    else
        echo "Commit cancelled."
        exit 0
    fi
}

# Function to push changes to the remote repository
push_changes() {
    local BRANCH_NAME=$1
    git push -u origin "$BRANCH_NAME" || { echo "Failed to push changes to the remote repository."; exit 1; }
    echo "Pushed changes to the remote repository on branch '$BRANCH_NAME'"
}

# Set root directory path
ROOT_DIR="$(pwd)/uhc-react-native"

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

# Change to root directory
cd "$ROOT_DIR" || { echo "Failed to change directory to $ROOT_DIR"; exit 1; }

# Create a new branch from the development branch
create_new_branch_from_development "$BRANCH_NAME"

# Prompt for new dependency version
read -p "Enter new dependency version for @optum-fpc-psx-mobile-apps/fpcpsxnative: " DEP_VERSION

# Update the main version in packages/arcade/package.json
update_package_version "$PACKAGE_JSON_PATH_ARCADE" "$MONTH" "$DATE"

# Update the dependency version in packages/arcade/package.json
DEP_NAME="@optum-fpc-psx-mobile-apps/fpcpsxnative"
update_dependency_version "$PACKAGE_JSON_PATH_ARCADE" "$DEP_NAME" "$DEP_VERSION"

# Update the dependency version in packages/guided-search/package.json
update_dependency_version "$PACKAGE_JSON_PATH_GUIDED_SEARCH" "$DEP_NAME" "$DEP_VERSION"

# Run yarn install at the root directory
run_yarn_install "$ROOT_DIR"

# Prompt for commit message
read -p "Enter commit message: " COMMIT_MESSAGE

# Commit changes to Git
commit_changes "$ROOT_DIR" "$COMMIT_MESSAGE"

# Push changes to the remote repository
push_changes "$BRANCH_NAME"

echo "Script completed successfully."





```
