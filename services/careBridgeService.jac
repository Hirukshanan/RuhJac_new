import from services.careBridgeModel { StoryDraft, InformationSource, CareFacility, CareEpisode, PatientReportedDetail, ConfirmedConsultationSummary, HealthcareInformationSource, HealthcareFacility, FacilityMatch, ReportsDetail, ConfirmsSummary, SupportsWithSource, MatchesFacility, MatchTarget }

obj HandoverResult {
    has story: StoryDraft;
    has source: InformationSource;
    has facilities: list[CareFacility];
    has directory_is_sample: bool;
    has ai_status: str;
}

# LLM extraction is deliberately not required: configured credentials are not available
# in this runtime. This draft preserves the exact user text and does not infer symptoms.
def:pub prepareHandover(concern: str, area: str, language: str) -> HandoverResult {
    if len(concern.strip()) < 3 {
        raise ValueError("Please describe your concern in a few words.");
    }
    safe_area = area.strip() if area.strip() else "Colombo";
    episode = CareEpisode(area=safe_area, language=language, temporary=True);
    episode +>:ReportsDetail(label="User's own words"):+> PatientReportedDetail(label="User's own words", value=concern.strip());
    source = InformationSource(
        title="World Health Organization: Health topics",
        url="https://www.who.int/health-topics",
        reviewed="Publication date varies by topic",
        note="Browse official topic pages. This demo does not retrieve topic-specific article text; no generated medical advice is shown as fact."
    );
    episode +>:SupportsWithSource:+> HealthcareInformationSource(title=source.title, url=source.url, reviewed=source.reviewed);
    facilities: list[CareFacility] = [
        CareFacility(name="National Hospital of Sri Lanka", category="Teaching hospital (sample directory entry)", address="Regent Street, Colombo 10", reason="Sample central Colombo public hospital entry. Confirm the service you need directly.", map_url="https://www.google.com/maps/search/?api=1&query=National+Hospital+of+Sri+Lanka"),
        CareFacility(name="Lady Ridgeway Hospital for Children", category="Children's hospital (sample directory entry)", address="Dr Danister De Silva Mawatha, Colombo 08", reason="Sample directory entry for children's care. Confirm suitability and services directly.", map_url="https://www.google.com/maps/search/?api=1&query=Lady+Ridgeway+Hospital+Colombo"),
        CareFacility(name="Colombo South Teaching Hospital", category="Teaching hospital (sample directory entry)", address="Kalubowila, Dehiwala-Mount Lavinia", reason="Sample facility in the wider Colombo area. Confirm location and services directly.", map_url="https://www.google.com/maps/search/?api=1&query=Colombo+South+Teaching+Hospital+Kalubowila")
    ];
    for facility in facilities {
        match_node = episode +>:MatchesFacility(reason=facility.reason, map_url=facility.map_url):+> FacilityMatch(reason=facility.reason, map_url=facility.map_url);
        match_node +>:MatchTarget:+> HealthcareFacility(name=facility.name, category=facility.category, address=facility.address, source="Sample demo entry; not verified against the government directory.");
    }
    return HandoverResult(story=StoryDraft(concern=concern.strip()), source=source, facilities=facilities, directory_is_sample=True, ai_status="AI extraction is not connected in this preview; your words are preserved without interpretation.");
}

def:pub confirmHandover(concern: str, symptoms: str, timeline: str, changes: str, history: str, medicines: str, questions: str, area: str, language: str) -> bool {
    if len(concern.strip()) < 3 or len(area.strip()) == 0 {
        return False;
    }
    episode = CareEpisode(area=area.strip(), language=language, temporary=True);
    summary_text = "Main concern: " + concern.strip() + "\nReported symptoms: " + symptoms + "\nTimeline: " + timeline + "\nChanges: " + changes + "\nRelevant history: " + history + "\nMedicines or allergies: " + medicines + "\nQuestions: " + questions;
    episode +>:ConfirmsSummary:+> ConfirmedConsultationSummary(text=summary_text, confirmed=True);
    return True;
}
