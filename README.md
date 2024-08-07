# Feature Flags

This repository maintains the feature flags for each release in JSON format. Feature flags are separated by lines of business, with common features applied globally.

## Current Release

- [Feature Flags JSON](feature-flags/feature-flags.json)

## JSON Structure

Each JSON file contains the feature flags for the corresponding release. The structure of the JSON file is as follows:

```json
{
  "version": "1.0.0",
  "releaseDate": "2024-08-05",
  "common": {
  },
  "MNR": {
    "EnableFeatureX": false
  },
  "CNS": {
    "EnableFeatureY": true
  },
  "ENI": {
    "EnableFeatureZ": true
  },
  "IFP": {
    "EnableFeatureA": false
  },
  "USP": {
    "EnableFeatureB": true
  },
  "UNET": {
    "EnableFeatureC": false
  }
}
