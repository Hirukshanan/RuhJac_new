import from ..services.careBridgeService { prepareHandover, confirmHandover, HandoverResult }
import from ..lib.download { trigger_download }
import from ..lib.languages { language_locale, voice_label }
import from .voice.VoiceInput { VoiceInput }
import from .voice.ResponseSpeech { ResponseSpeech }

import from .ui.card { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter }
import from .ui.button { Button }
import from .ui.textarea { Textarea }
import from .ui.input { Input }
import from .ui.badge { Badge }

# Keep episode content in component state only. Clear it by refreshing the page.
def:pub CareBridgeWorkspace() -> JsxElement {
    has language: str = "English";
    has area: str = "Colombo";
    has concern: str = "";
    has symptoms: str = "Not provided";
    has timeline: str = "Not provided";
    has changes: str = "Not provided";
    has history: str = "Not provided";
    has medicines: str = "Not provided";
    has questions: str = "What should I discuss with my clinician?";
    has result: bool = False;
    has facility_cards: list[dict[str, any]] = [];
    has error_message: str = "";
    has confirmed: bool = False;
    has status_message: str = "";

    def change_language(e: ChangeEvent) {
        language = e.target.value;
        confirmed = False;
        status_message = "";
    }
    def accept_transcript(text: str) {
        concern = concern.rstrip() + " " + text if concern.strip() else text;
        confirmed = False;
        status_message = "";
    }
    def change_area(e: ChangeEvent) { area = e.target.value; }
    def change_concern(e: ChangeEvent) { concern = e.target.value; confirmed = False; }
    def change_symptoms(e: ChangeEvent) { symptoms = e.target.value; confirmed = False; }
    def change_timeline(e: ChangeEvent) { timeline = e.target.value; confirmed = False; }
    def change_changes(e: ChangeEvent) { changes = e.target.value; confirmed = False; }
    def change_history(e: ChangeEvent) { history = e.target.value; confirmed = False; }
    def change_medicines(e: ChangeEvent) { medicines = e.target.value; confirmed = False; }
    def change_questions(e: ChangeEvent) { questions = e.target.value; confirmed = False; }

    def prepare_story(e: MouseEvent) {
        error_message = "";
        status_message = "";
        confirmed = False;
        if len(concern.strip()) < 3 {
            error_message = "Please describe your concern in a few words.";
            return;
        }
        facilities: list[dict[str, any]] = [
            {"name": "National Hospital of Sri Lanka", "category": "Teaching hospital (sample directory entry)", "address": "Regent Street, Colombo 10", "reason": "Sample central Colombo public hospital entry. Confirm services directly.", "map_url": "https://www.google.com/maps/search/?api=1&query=National+Hospital+of+Sri+Lanka", "telephone": "Not available"},
            {"name": "Lady Ridgeway Hospital for Children", "category": "Children's hospital (sample directory entry)", "address": "Dr Danister De Silva Mawatha, Colombo 08", "reason": "Sample directory entry for children's care. Confirm suitability directly.", "map_url": "https://www.google.com/maps/search/?api=1&query=Lady+Ridgeway+Hospital+Colombo", "telephone": "Not available"},
            {"name": "Colombo South Teaching Hospital", "category": "Teaching hospital (sample directory entry)", "address": "Kalubowila, Dehiwala-Mount Lavinia", "reason": "Sample facility in the wider Colombo area. Confirm location and services directly.", "map_url": "https://www.google.com/maps/search/?api=1&query=Colombo+South+Teaching+Hospital+Kalubowila", "telephone": "Not available"}
        ];
        result = True;
        facility_cards = facilities;
        symptoms = "Not provided";
        timeline = "Not provided";
        changes = "Not provided";
        history = "Not provided";
        medicines = "Not provided";
        questions = "What should I discuss with my clinician?";
    }

    def confirm_story(e: MouseEvent) {
        if not result { error_message = "Prepare a story draft first."; return; }
        if len(area.strip()) == 0 { error_message = "Enter a Colombo area before confirming."; return; }
        confirmed = True;
        error_message = "";
        status_message = "Your reviewed handover is ready to download. It has not been sent to anyone.";
    }

    def download_handover(e: MouseEvent) {
        if not confirmed { return; }
        text = "CareBridge consultation handover\nUser-reviewed summary; not a diagnosis\n\nArea: " + area + "\nLanguage: " + language + "\n\nMain concern (reported): " + concern + "\nReported symptoms: " + symptoms + "\nTimeline: " + timeline + "\nChanges: " + changes + "\nRelevant history: " + history + "\nMedicines or allergies volunteered: " + medicines + "\nQuestions for clinician: " + questions + "\n\nPlease verify this summary with the clinician. Generated locally from user-entered details; not sent to a provider.";
        trigger_download(text);

    }

    return <div className="min-h-svh bg-muted/40 text-foreground">
        <header className="border-b bg-background">
            <div className="mx-auto flex max-w-7xl items-center justify-between gap-4 px-4 py-4 sm:px-6">
                <div className="flex items-center gap-3">
                    <div className="flex size-10 items-center justify-center rounded-xl bg-primary text-lg font-semibold text-primary-foreground">C</div>
                    <div><p className="text-lg font-semibold tracking-tight">CareBridge</p><p className="text-xs text-muted-foreground">Colombo care navigation</p></div>
                </div>
                <label lang={language_locale(language)} className="flex flex-wrap items-center gap-2 text-sm">{voice_label(language, "language")}
                    <select id="carebridge-language" aria-label={voice_label(language, "language")} value={language} onChange={change_language} className="h-9 rounded-md border border-input bg-background px-2 text-sm">
                        <option value="English">English</option><option value="Sinhala">සිංහල</option><option value="Tamil">தமிழ்</option>
                    </select>
                </label>
            </div>
        </header>
        <main className="mx-auto flex max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 sm:py-8">
            <section className="flex flex-col gap-3 rounded-2xl border bg-card p-5 shadow-sm sm:p-7">
                <Badge variant="secondary" className="w-fit">Care navigation, not diagnosis</Badge>
                <h1 className="max-w-3xl text-balance text-3xl font-semibold tracking-tight sm:text-4xl">Prepare for a clearer conversation about your health.</h1>
                <p className="max-w-3xl text-sm leading-6 text-muted-foreground sm:text-base">Share what you have noticed, review a summary in your own words, and explore Colombo facilities. Your story stays in this temporary session.</p>
                <div className="flex flex-col gap-2 sm:max-w-sm">
                    <label htmlFor="area" className="text-sm font-medium">Colombo area</label>
                    <Input id="area" value={area} onChange={change_area} placeholder="For example, Borella" className="bg-background" />
                    <p className="text-xs text-muted-foreground">Enter an area manually. No location access is requested.</p>
                </div>
            </section>

            <div className="grid items-start gap-6 lg:grid-cols-[minmax(0,1.15fr)_minmax(340px,0.85fr)]">
                <div className="flex flex-col gap-6">
                    <Card className="shadow-sm">
                        <CardHeader><CardTitle>Tell us what is going on</CardTitle><CardDescription>Use your own words. We will not infer symptoms or diagnose.</CardDescription></CardHeader>
                        <CardContent className="flex flex-col gap-3">
                            <p lang={language_locale(language)} className="text-sm leading-6">{voice_label(language, "prompt")}</p>
                            <ResponseSpeech key={"prompt-" + language} language={language} text={voice_label(language, "prompt")} />
                            <p lang={language_locale(language)} className="text-xs leading-5 text-muted-foreground">{voice_label(language, "scope")}</p>
                            <label htmlFor="concern" className="text-sm font-medium">What would you like help navigating?</label>
                            <Textarea id="concern" lang={language_locale(language)} value={concern} onChange={change_concern} placeholder="For example: I have had a headache since yesterday, and I would like help preparing to speak with a clinician." className="min-h-32 resize-y bg-background" />
                            <VoiceInput key={language} language={language} onTranscript={accept_transcript} />
                            <p className="text-xs text-muted-foreground">Avoid entering identifying details you do not need for this demo.</p>
                        </CardContent>
                        <CardFooter className="flex flex-wrap gap-3"><Button onClick={prepare_story} disabled={len(concern.strip()) < 3}>Prepare my story</Button><span className="text-xs text-muted-foreground">No medical advice is generated.</span></CardFooter>
                    </Card>

                    {if result {
                        <Card className="shadow-sm">
                            <CardHeader><div className="flex flex-wrap items-center justify-between gap-2"><div><CardTitle>Your story to review</CardTitle><CardDescription>These details are editable. “Not provided” means we do not know.</CardDescription></div><Badge variant="outline">Not confirmed</Badge></div></CardHeader>
                            <CardContent className="flex flex-col gap-4">
                                <div className="rounded-lg bg-muted/60 p-3"><p className="mb-1 text-xs font-medium text-muted-foreground">Main concern, your words</p><p className="whitespace-pre-wrap text-sm leading-6">{concern}</p></div>
                                <div className="grid gap-3 sm:grid-cols-2">
                                    <div className="flex flex-col gap-1.5"><label htmlFor="symptoms" className="text-sm font-medium">Reported symptoms</label><Textarea id="symptoms" value={symptoms} onChange={change_symptoms} className="min-h-20 bg-background" /></div>
                                    <div className="flex flex-col gap-1.5"><label htmlFor="timeline" className="text-sm font-medium">Timeline</label><Textarea id="timeline" value={timeline} onChange={change_timeline} className="min-h-20 bg-background" /></div>
                                    <div className="flex flex-col gap-1.5"><label htmlFor="changes" className="text-sm font-medium">Changes noticed</label><Textarea id="changes" value={changes} onChange={change_changes} className="min-h-20 bg-background" /></div>
                                    <div className="flex flex-col gap-1.5"><label htmlFor="history" className="text-sm font-medium">Relevant history</label><Textarea id="history" value={history} onChange={change_history} className="min-h-20 bg-background" /></div>
                                    <div className="flex flex-col gap-1.5"><label htmlFor="medicines" className="text-sm font-medium">Medicines or allergies volunteered</label><Textarea id="medicines" value={medicines} onChange={change_medicines} className="min-h-20 bg-background" /></div>
                                    <div className="flex flex-col gap-1.5"><label htmlFor="questions" className="text-sm font-medium">Questions for the clinician</label><Textarea id="questions" value={questions} onChange={change_questions} className="min-h-20 bg-background" /></div>
                                </div>
                                <p className="text-xs leading-5 text-muted-foreground">Unknown details: not yet discussed. AI extraction is not connected in this preview; your original words are preserved without interpretation.</p>
                                <Button onClick={confirm_story} className="w-fit">I reviewed this summary</Button>
                                {if confirmed { <p role="status" className="text-sm font-medium text-primary">Confirmed by you. Ready to download.</p> }}
                            </CardContent>
                            {if confirmed { <CardFooter><Button variant="outline" onClick={download_handover}>Download handover</Button></CardFooter> }}
                        </Card>
                    }}
                    {if error_message { <p role="alert" className="rounded-lg border border-destructive/30 bg-destructive/5 p-3 text-sm text-destructive">{error_message}</p> }}
                    {if status_message {
                        <div lang={language_locale(language)} className="flex flex-col gap-2">
                            <p role="status" className="text-sm text-muted-foreground">{voice_label(language, "confirmed_reply")}</p>
                            <ResponseSpeech key={"confirmation-" + language} language={language} text={voice_label(language, "confirmed_reply")} />
                        </div>
                    }}
                </div>

                <aside className="flex flex-col gap-6">
                    <Card className="shadow-sm">
                        <CardHeader><CardTitle>General health information</CardTitle><CardDescription>Official source link; this preview does not fetch or invent topic-specific guidance.</CardDescription></CardHeader>
                        <CardContent className="flex flex-col gap-3">
                            {if result {
                                <div className="rounded-lg border bg-muted/30 p-4">
                                    <p className="text-sm font-semibold">World Health Organization: Health topics</p>
                                    <p className="mt-1 text-xs leading-5 text-muted-foreground">Browse official topic pages. Topic-specific guidance is not retrieved in this demo.</p>
                                    <p className="mt-2 text-xs text-muted-foreground">Publication date varies by topic.</p>
                                    <a href="https://www.who.int/health-topics" target="_blank" rel="noreferrer" className="mt-3 inline-flex text-sm font-medium text-primary underline underline-offset-4">Open WHO health topics</a>
                                </div>
                            } else {
                                <p className="rounded-lg border border-dashed p-4 text-sm leading-6 text-muted-foreground">Describe a concern to see the source link alongside your draft. If an answer is not available from a cited source, CareBridge will say so rather than guess.</p>
                            }}
                        </CardContent>
                    </Card>
                    <Card className="shadow-sm">
                        <CardHeader><div className="flex flex-wrap items-center justify-between gap-2"><div><CardTitle>Facilities near Colombo</CardTitle><CardDescription>Sample directory entries, not verified live results.</CardDescription></div><Badge variant="outline">Demo data</Badge></div></CardHeader>
                        <CardContent className="flex flex-col gap-3">
                            {if result {
                                for (i, facility) in enumerate(facility_cards) {
                                    <article key={str(i)} className="rounded-lg border bg-background p-4">
                                        <h3 className="font-semibold">{facility["name"]}</h3>
                                        <p className="mt-1 text-xs font-medium text-primary">{facility["category"]}</p>
                                        <p className="mt-2 text-sm text-muted-foreground">{facility["address"]}</p>
                                        <p className="mt-2 text-sm leading-5">{facility["reason"]}</p>
                                        <p className="mt-2 text-xs text-muted-foreground">Phone: {facility["telephone"]} · Opening hours and availability: needs confirmation.</p>
                                        <a href={facility["map_url"]} target="_blank" rel="noreferrer" className="mt-3 inline-flex text-sm font-medium text-primary underline underline-offset-4">Open map directions</a>
                                    </article>
                                }
                                <p className="text-xs leading-5 text-muted-foreground">Sri Lanka NSDI ArcGIS returned a query error during testing. These sample records are not verified against the directory. Contact facilities directly to confirm services, hours, and availability.</p>
                            } else {
                                <p className="rounded-lg border border-dashed p-4 text-sm leading-6 text-muted-foreground">Facility matches will appear after you prepare a story. No doctors, opening hours, prices, or appointment slots are claimed.</p>
                            }}
                        </CardContent>
                    </Card>
                </aside>
            </div>

            <section className="rounded-xl border border-destructive/30 bg-destructive/5 p-4 sm:p-5" aria-label="Emergency help">
                <p className="font-semibold text-destructive">Need urgent help now?</p>
                <p className="mt-1 text-sm leading-6">Do not wait for this app or continue a long conversation. Contact local emergency services or go to the nearest emergency department. This demo does not provide verified emergency numbers.</p>
            </section>
            <footer className="flex flex-col gap-1 border-t py-4 text-xs leading-5 text-muted-foreground sm:flex-row sm:justify-between">
                <span>Privacy: this demo keeps your story in temporary page memory; refreshing clears it. It is not sent to a provider.</span>
                <span>For navigation and communication only. Not a diagnosis or treatment system.</span>
            </footer>
        </main>
    </div>;
}
