obj StoryDraft {
    has concern: str;
    has symptoms: str = "Not provided";
    has timeline: str = "Not provided";
    has changes: str = "Not provided";
    has relevant_history: str = "Not provided";
    has medicines_allergies: str = "Not provided";
    has clinician_questions: str = "What should I discuss with my clinician?";
    has unknown_details: str = "Not yet discussed";
}

obj InformationSource {
    has title: str;
    has url: str;
    has note: str;
    has reviewed: str = "Review date not available";
}

obj CareFacility {
    has name: str;
    has category: str;
    has address: str;
    has reason: str;
    has map_url: str;
    has telephone: str = "Not available";
    has ownership: str = "Not available";
}

node CareEpisode {
    has area: str = "Colombo";
    has language: str = "English";
    has temporary: bool = True;
}

node PatientReportedDetail {
    has label: str;
    has value: str;
}

node ConfirmedConsultationSummary {
    has text: str;
    has confirmed: bool = False;
}

node HealthcareInformationSource {
    has title: str;
    has url: str;
    has reviewed: str;
}

node HealthcareFacility {
    has name: str;
    has category: str;
    has address: str;
    has source: str;
}

node FacilityMatch {
    has reason: str;
    has map_url: str;
}

edge ReportsDetail: CareEpisode --> PatientReportedDetail {}
edge ConfirmsSummary: CareEpisode --> ConfirmedConsultationSummary {}
edge SupportsWithSource: CareEpisode --> HealthcareInformationSource {}
edge MatchesFacility: CareEpisode --> FacilityMatch {}
edge MatchTarget: FacilityMatch --> HealthcareFacility {}
