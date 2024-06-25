# Flutter_Covid-19

# Sample

```
#!/bin/bash

# Function to update the main version in a package.json file
update_package_version() {
    local PACKAGE_JSON_PATH=$1
    local NEW_VERSION=$2

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

# Function to create a new branch from a specified branch
create_new_branch_from_specified() {
    local BRANCH_NAME=$1
    local FROM_BRANCH=$2

    # Check if branch already exists locally
    if git show-ref --quiet "refs/heads/$BRANCH_NAME"; then
        local TIME_SUFFIX=$(date +"%H%M%S")
        BRANCH_NAME="${BRANCH_NAME}-${TIME_SUFFIX}"
    fi

    # Switch to the base branch and update it
    if ! git checkout "$FROM_BRANCH" > /dev/null 2>&1; then
        echo "Failed to switch to branch '$FROM_BRANCH'." >&2
        exit 1
    fi
    if ! git pull origin "$FROM_BRANCH" > /dev/null 2>&1; then
        echo "Failed to pull latest changes from '$FROM_BRANCH'." >&2
        exit 1
    fi

    # Create and switch to the new branch
    if ! git checkout -b "$BRANCH_NAME" > /dev/null 2>&1; then
        echo "Failed to create and switch to branch '$BRANCH_NAME'." >&2
        exit 1
    fi

    # Return the new branch name
    echo "$BRANCH_NAME"
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

    # List tracked and modified files for commit
    local MODIFIED_FILES=$(git ls-files --modified --exclude-standard)
    if [ -z "$MODIFIED_FILES" ]; then
        echo "No changes to commit."
        return
    fi

    echo "Modified files:"
    for file in $MODIFIED_FILES; do
        echo "File: $file"
        git --no-pager diff -- "$file"
        echo ""

        # Prompt for each file to add it to the staging area or not
        read -r -p "Do you want to stage this file for commit? [y/N] " response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            git add "$file"
            echo "Added $file to staging area."
        else
            echo "Skipped $file."
        fi
    done

    # Commit if any files are staged
    if git diff --cached --quiet; then
        echo "No files staged for commit. Exiting."
        return
    else
        git commit -m "$COMMIT_MESSAGE" || { echo "Failed to commit changes."; exit 1; }
        echo "Committed changes to Git with message: $COMMIT_MESSAGE"
    fi
}

# Function to push changes to the remote repository
push_changes() {
    local BRANCH_NAME=$1
    local RESPONSE

    read -r -p "Do you want to push branch '$BRANCH_NAME' to the remote repository? [y/N] " RESPONSE
    if [[ "$RESPONSE" =~ ^[Yy]$ ]]; then
        git push -u origin "$BRANCH_NAME" || { echo "Failed to push changes to the remote repository."; exit 1; }
        echo "Pushed changes to the remote repository on branch '$BRANCH_NAME'"
    else
        echo "Push cancelled."
        exit 0
    fi
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

# Default branch name format: psx/${MONTH}-${DATE}
DEFAULT_BRANCH_NAME="psx/${MONTH}-${DATE}"

# Prompt to use the default branch name
read -p "Use default branch name '$DEFAULT_BRANCH_NAME'? [y/N] " USE_DEFAULT_BRANCH
if [[ "$USE_DEFAULT_BRANCH" =~ ^[Yy]$ ]]; then
    BRANCH_NAME="$DEFAULT_BRANCH_NAME"
else
    read -p "Enter custom branch name: " BRANCH_NAME
fi

# Prompt to use the default current branch 'development'
read -p "Create new branch from 'development' branch? [y/N] " USE_DEFAULT_BASE_BRANCH
if [[ "$USE_DEFAULT_BASE_BRANCH" =~ ^[Yy]$ ]]; then
    BASE_BRANCH="development"
else
    read -p "Enter the branch name to create the new branch from: " BASE_BRANCH
fi

# Change to root directory
cd "$ROOT_DIR" || { echo "Failed to change directory to $ROOT_DIR"; exit 1; }

# Create a new branch from the specified branch
BRANCH_NAME=$(create_new_branch_from_specified "$BRANCH_NAME" "$BASE_BRANCH")
echo "Branch created: $BRANCH_NAME" # For debugging

# Read the current version from the package.json file
CURRENT_VERSION=$(jq -r '.version' "$PACKAGE_JSON_PATH_ARCADE")
BASE_VERSION=$(echo "$CURRENT_VERSION" | sed 's/-.*$//')
DEFAULT_VERSION="${BASE_VERSION}-psx-main-${MONTH}-${DATE}"

# Prompt to use the default version
read -p "Use default version '$DEFAULT_VERSION'? [y/N] " USE_DEFAULT_VERSION
if [[ "$USE_DEFAULT_VERSION" =~ ^[Yy]$ ]]; then
    NEW_VERSION="$DEFAULT_VERSION"
else
    read -p "Enter custom version name: " NEW_VERSION
fi

# Prompt for new dependency version
read -p "Enter new dependency version for @optum-fpc-psx-mobile-apps/fpcpsxnative: " DEP_VERSION

# Update the main version in packages/arcade/package.json
update_package_version "$PACKAGE_JSON_PATH_ARCADE" "$NEW_VERSION"

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
