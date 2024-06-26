```
# Function to update the YAML file for triggering builds and changing upload_to_sauce_labs
update_yaml_for_build_trigger() {
    local YAML_FILE=$1
    local NEW_BRANCH=$2
    local TEMP_YAML=temp_volcan_android_internal_build.yml

    # Backup the original YAML file
    cp "$YAML_FILE" "$TEMP_YAML"

    # Update the YAML file:
    awk -v newBranch="$NEW_BRANCH" '
    BEGIN {in_on = 0}
    /on:/ {in_on = 1; print "on:"; next}
    in_on && /schedule:/ {next}
    in_on && /cron:/ {in_on = 0; print "  push:\n    branches:\n      - " newBranch; next}
    {sub(/'\'false'\'/, "'\''true'\'")}
    {print}
    ' "$TEMP_YAML" > "$TEMP_YAML.new"

    # Replace the original YAML file if changes are successful
    if grep -q "push:\n    branches:\n      - $NEW_BRANCH" "$TEMP_YAML.new"; then
        mv "$TEMP_YAML.new" "$YAML_FILE"
        echo "Updated build trigger and upload_to_sauce_labs to 'true' in $YAML_FILE"
    else
        echo "Failed to update build trigger in $YAML_FILE"
        rm "$TEMP_YAML.new"
        exit 1
    fi

    # Clean up
    rm -f "$TEMP_YAML"
}


# Function to update the YAML file for iOS builds
update_yaml_for_ios_build_trigger() {
    local YAML_FILE=$1
    local NEW_BRANCH=$2
    local TEMP_YAML=temp_volcan_ios_internal_build.yml

    # Backup the original YAML file
    cp "$YAML_FILE" "$TEMP_YAML"

    # Update the YAML file:
    awk -v newBranch="$NEW_BRANCH" '
    BEGIN {in_on = 0}
    /on:/ {in_on = 1; print "on:"; next}
    in_on && /schedule:/ {next}
    in_on && /cron:/ {in_on = 0; print "  push:\n    branches:\n      - " newBranch; next}
    {sub(/'\'false'\'/, "'\''true'\'")}
    {print}
    ' "$TEMP_YAML" > "$TEMP_YAML.new"

    # Replace the original YAML file if changes are successful
    if grep -q "push:\n    branches:\n      - $NEW_BRANCH" "$TEMP_YAML.new"; then
        mv "$TEMP_YAML.new" "$YAML_FILE"
        echo "Updated build trigger and upload_to_sauce_labs/upload_to_firebase to 'true' in $YAML_FILE"
    else
        echo "Failed to update build trigger in $YAML_FILE"
        rm "$TEMP_YAML.new"
        exit 1
    fi

    # Clean up
    rm -f "$TEMP_YAML"
}


```
