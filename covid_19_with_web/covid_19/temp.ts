// Default Feature Flag Values
const defaultFeatureFlags: { [key: string]: boolean } = {
  EnableVisionChip: true,
  EnableUpcomingAvailability: true,
  EnableShowEapTile: true,
  EnablePreferredProviderBadge: true,
  EnablePreferredFacilityIdentification: true,
  EnableNewHealthgradesExperience: true,
  EnableMockCompareCard: false,
  EnableMedicalSpecialistsActiveReferrals: false,
  EnableLlm: true,
  EnableGetHealthgradesData: true,
  EnableFirstVisitModal: true,
  EnableDentalChip: true,
  EnableDecemberRelease: true,
  EnableCountySearchAlert: true,
  EnableCostExperienceNative: true,
  EnableConsoleLogs: true,
  EnableAnalyticsV1: true,
  EnableExtendedTypeaheadAnalytics: true,
  EnableAnalyticsTrackBack: true,
  EnableAcoFilter: true,
  EnablePreferredFacilitySearch: true,
  EnableSuppressBehavioralHealthContent: true,
  EnableBehavioralVirtualPsuedocodes: true,
  EnableTrackScreenLoad: true,
  EnableMedicalNewRollupCodes: true,
  EnableBehavioralNewRollupCodes: true,
  EnableVisionNewRollupCodes: true,
  EnableDentalNewRollupCodes: true,
  EnablePlanningForCare: false,
  EnableAnalyticsMixedResultsPage: true,
  EnableAnalyticsIntroViewOfPsxVideo: true,
  EnableNewPreferredFacilityL2Page: true,
  EnableAnalyticsErrorNullSearchPage: true,
  EnableAnalyticsPcpSelectionFlow: true,
  EnableShowSelectedLocationAcoProvider: true,
  EnableAutocompleteCaptureResults: true,
  EnableNewLocationSelectionFlow: true,
  EnableAnalyticsFindCareLandingPage: true,
  EnableAnalyticsMapView: true,
  EnableDisplayAvailabilityProviderDetails: true,
  EnableTypeaheadGeneralSearch: true,
  EnablePsxProviderRecommendations: true,
  EnableOxfordPlnFlag: true,
  EnableAutocompleteRollUpCodeNameSearch: true,
  EnableMedicareCosmosPcp: true,
  EnablePcpTerminationDate: true,
  EnableShowAcceptsMedicaid: true,
  EnableAnalyticsListViewPage: true,
  EnableAdditionalResources: true,
  EnableRecentVisionVisit: true,
  EnableRecentDentalVisit: true,
  EnablePreEffectivePlans: true,
  EnableMembers: true,
  EnableIdentifyNonTieredProviderLocations: true,
};

// Feature Flag Service with Default Values
export const FeatureFlagService = (
  flags: LineOfBusiness | undefined,
  flag: string,
  lineOfBusiness: string | undefined,
  population?: string
): boolean => {
  if (!flags) return defaultFeatureFlags[flag] ?? false; // Fallback to default if flags are not provided

  const lobFlags = lineOfBusiness ? flags[lineOfBusiness] : undefined;
  if (!lobFlags) {
    return flags.common?.[flag] ?? defaultFeatureFlags[flag] ?? false;
  }

  if (population && lobFlags.population?.[population]?.[flag] !== undefined) {
    return lobFlags.population[population][flag];
  }

  if (lobFlags[flag] !== undefined) {
    return lobFlags[flag];
  }

  return flags.common?.[flag] ?? defaultFeatureFlags[flag] ?? false;
};

// Feature Flag Configuration Initialization
export const FeatureFlagProvider = () => {
  let flags: LineOfBusiness | undefined;
  let lineOfBusiness: string | undefined;
  let population: string | undefined;

  return {
    initialize: (config: LineOfBusiness, lob: string, pop?: string) => {
      flags = config;
      lineOfBusiness = lob;
      population = pop;
    },
    setLineOfBusiness: (lob: string) => {
      lineOfBusiness = lob;
    },
    setPopulation: (pop: string) => {
      population = pop;
    },
    getFeatureFlagValue: (flag: string): boolean => {
      return FeatureFlagService(flags, flag, lineOfBusiness, population);
    },
  };
};

// Usage Example
const featureFlagProvider = FeatureFlagProvider();

// Initialize with JSON Config, Line of Business, and Population
featureFlagProvider.initialize(jsonConfig, "eni", "usp");

// Get Feature Flag Values
const enableVisionChip = featureFlagProvider.getFeatureFlagValue("EnableVisionChip");
const enableUpcomingAvailability = featureFlagProvider.getFeatureFlagValue("EnableUpcomingAvailability");

// Modify Line of Business or Population Later if Needed
featureFlagProvider.setLineOfBusiness("mnr");
const enableRecentVisionVisit = featureFlagProvider.getFeatureFlagValue("EnableRecentVisionVisit");







******




  // TypeScript Types
type FeatureFlags = {
  [key: string]: boolean | undefined;
};

type Population = {
  [key: string]: FeatureFlags | undefined;
};

// Generic Line of Business Type
type LineOfBusiness = {
  common: FeatureFlags;
  [key: string]: FeatureFlags & { population?: Population } | undefined;
};

// Feature Flag Service
export const FeatureFlagService = (
  flags: LineOfBusiness | undefined,
  flag: string,
  lineOfBusiness: string | undefined,
  population?: string
): boolean => {
  if (!flags) return false; // Fallback if flags are not provided

  const lobFlags = lineOfBusiness ? flags[lineOfBusiness] : undefined;
  if (!lobFlags) {
    return flags.common?.[flag] ?? false;
  }

  if (population && lobFlags.population?.[population]?.[flag] !== undefined) {
    return lobFlags.population[population][flag];
  }

  if (lobFlags[flag] !== undefined) {
    return lobFlags[flag];
  }

  return flags.common?.[flag] ?? false;
};

// JSON Configuration
const jsonConfig: LineOfBusiness = {
  version: "1.0.0",
  releaseDate: "2024-08-05",
  common: {
    EnableVisionChip: true,
    EnableUpcomingAvailability: true,
    EnableShowEapTile: true,
    EnablePreferredProviderBadge: true,
    EnablePreferredFacilityIdentification: true,
    EnableNewHealthgradesExperience: true,
    EnableMockCompareCard: false,
    EnableMedicalSpecialistsActiveReferrals: false,
    EnableLlm: true,
    EnableGetHealthgradesData: true,
    EnableFirstVisitModal: true,
    EnableDentalChip: true,
    EnableDecemberRelease: true,
    EnableCountySearchAlert: true,
    EnableCostExperienceNative: true,
    EnableConsoleLogs: true,
    EnableAnalyticsV1: true,
    EnableExtendedTypeaheadAnalytics: true,
    EnableAnalyticsTrackBack: true,
    EnableAcoFilter: true,
    EnablePreferredFacilitySearch: true,
    EnableSuppressBehavioralHealthContent: true,
    EnableBehavioralVirtualPsuedocodes: true,
    EnableTrackScreenLoad: true,
    EnableMedicalNewRollupCodes: true,
    EnableBehavioralNewRollupCodes: true,
    EnableVisionNewRollupCodes: true,
    EnableDentalNewRollupCodes: true,
    EnablePlanningForCare: false,
    EnableAnalyticsMixedResultsPage: true,
    EnableAnalyticsIntroViewOfPsxVideo: true,
    EnableNewPreferredFacilityL2Page: true,
    EnableAnalyticsErrorNullSearchPage: true,
    EnableAnalyticsPcpSelectionFlow: true,
    EnableShowSelectedLocationAcoProvider: true,
    EnableAutocompleteCaptureResults: true,
    EnableNewLocationSelectionFlow: true,
    EnableAnalyticsFindCareLandingPage: true,
    EnableAnalyticsMapView: true,
    EnableDisplayAvailabilityProviderDetails: true,
    EnableTypeaheadGeneralSearch: true,
    EnablePsxProviderRecommendations: true,
    EnableOxfordPlnFlag: true,
    EnableAutocompleteRollUpCodeNameSearch: true,
    EnableMedicareCosmosPcp: true,
    EnablePcpTerminationDate: true,
    EnableShowAcceptsMedicaid: true,
    EnableAnalyticsListViewPage: true,
    EnableAdditionalResources: true,
  },
  mnr: {
    EnableRecentVisionVisit: true,
    EnableRecentDentalVisit: true,
  },
  cns: {},
  eni: {
    EnableRecentVisionVisit: true,
    EnableRecentDentalVisit: true,
    EnablePreEffectivePlans: true,
    population: {
      usp: {
        EnableRecentVisionVisit: false,
        EnableRecentDentalVisit: false,
        EnableMembers: true,
        EnableIdentifyNonTieredProviderLocations: true,
      },
      unet: {
        EnableRecentVisionVisit: true,
        EnableRecentDentalVisit: true,
        EnableIdentifyNonTieredProviderLocations: true,
      },
    },
  },
  ifp: {},
};

// Create Feature Flag Variables
const featureFlags = [
  "EnableVisionChip",
  "EnableUpcomingAvailability",
  "EnableShowEapTile",
  "EnablePreferredProviderBadge",
  "EnablePreferredFacilityIdentification",
  "EnableNewHealthgradesExperience",
  "EnableMockCompareCard",
  "EnableMedicalSpecialistsActiveReferrals",
  "EnableLlm",
  "EnableGetHealthgradesData",
  "EnableFirstVisitModal",
  "EnableDentalChip",
  "EnableDecemberRelease",
  "EnableCountySearchAlert",
  "EnableCostExperienceNative",
  "EnableConsoleLogs",
  "EnableAnalyticsV1",
  "EnableExtendedTypeaheadAnalytics",
  "EnableAnalyticsTrackBack",
  "EnableAcoFilter",
  "EnablePreferredFacilitySearch",
  "EnableSuppressBehavioralHealthContent",
  "EnableBehavioralVirtualPsuedocodes",
  "EnableTrackScreenLoad",
  "EnableMedicalNewRollupCodes",
  "EnableBehavioralNewRollupCodes",
  "EnableVisionNewRollupCodes",
  "EnableDentalNewRollupCodes",
  "EnablePlanningForCare",
  "EnableAnalyticsMixedResultsPage",
  "EnableAnalyticsIntroViewOfPsxVideo",
  "EnableNewPreferredFacilityL2Page",
  "EnableAnalyticsErrorNullSearchPage",
  "EnableAnalyticsPcpSelectionFlow",
  "EnableShowSelectedLocationAcoProvider",
  "EnableAutocompleteCaptureResults",
  "EnableNewLocationSelectionFlow",
  "EnableAnalyticsFindCareLandingPage",
  "EnableAnalyticsMapView",
  "EnableDisplayAvailabilityProviderDetails",
  "EnableTypeaheadGeneralSearch",
  "EnablePsxProviderRecommendations",
  "EnableOxfordPlnFlag",
  "EnableAutocompleteRollUpCodeNameSearch",
  "EnableMedicareCosmosPcp",
  "EnablePcpTerminationDate",
  "EnableShowAcceptsMedicaid",
  "EnableAnalyticsListViewPage",
  "EnableAdditionalResources",
  "EnableRecentVisionVisit",
  "EnableRecentDentalVisit",
  "EnablePreEffectivePlans",
  "EnableMembers",
  "EnableIdentifyNonTieredProviderLocations",
];

// Function to Create Feature Flag Variables Dynamically
const createFeatureFlagVariables = (
  flags: LineOfBusiness | undefined,
  featureFlags: string[],
  lineOfBusiness?: string,
  population?: string
): { [key: string]: boolean } => {
  const featureFlagVariables: { [key: string]: boolean } = {};

  featureFlags.forEach((flag) => {
    featureFlagVariables[flag] = FeatureFlagService(flags, flag, lineOfBusiness ?? '', population);
  });

  return featureFlagVariables;
};

// Factory Function to Handle Initialization
export const useFeatureFlags = (
  initialFlags: LineOfBusiness | undefined,
  initialLineOfBusiness?: string,
  initialPopulation?: string
) => {
  let flags = initialFlags;
  let lineOfBusiness = initialLineOfBusiness;
  let population = initialPopulation;

  const setConfig = (newFlags: LineOfBusiness) => {
    flags = newFlags;
  };

  const setLineOfBusiness = (newLineOfBusiness: string) => {
    lineOfBusiness = newLineOfBusiness;
  };

  const setPopulation = (newPopulation: string) => {
    population = newPopulation;
  };

  const getFeatureFlags = () => createFeatureFlagVariables(flags, featureFlags, lineOfBusiness, population);

  return {
    setConfig,
    setLineOfBusiness,
    setPopulation,
    getFeatureFlags,
  };
};

// Usage Example
const { setConfig, setLineOfBusiness, setPopulation, getFeatureFlags } = useFeatureFlags(jsonConfig, 'eni', 'usp');

// Set or modify the configuration later if needed
setConfig(jsonConfig);
setLineOfBusiness('eni');
setPopulation('unet');

// Get feature flags
const featureFlagValues = getFeatureFlags();

// Access a specific feature flag
const EnableVisionChip = featureFlagValues["EnableVisionChip"];
const EnableUpcomingAvailability = featureFlagValues["EnableUpcomingAvailability"];
// Continue for other feature flags...
