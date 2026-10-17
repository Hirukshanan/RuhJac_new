import from ...lib.languages { language_locale, voice_label }
import from ...lib.browserSpeech { recognition_mode, new_recognition, recognition_error }
import from ..ui.button { Button }
import from ..ui.textarea { Textarea }

# Parent keys this component by language: switching language aborts the old
# session and requires fresh consent, without clearing the typed concern.
def:pub VoiceInput(language: str, onTranscript: Callable[[str], None]) -> JsxElement {
    has mode: str = "checking";
    has phase: str = "idle";
    has notice: str = "";
    has consent: bool = False;
    has draft: str = "";
    has interim: str = "";
    has has_transcript: bool = False;
    has session: Ref[any] = Ref(None);
    has alive: Ref[bool] = Ref(True);

    async can with entry {
        alive.current = True;
        support = await recognition_mode(language_locale(language));
        if alive.current { mode = support; }
    }

    can with exit {
        alive.current = False;
        current = session.current;
        session.current = None;
        if current {
            current.onstart = None;
            current.onresult = None;
            current.onerror = None;
            current.onend = None;
            try { current.abort(); } except Exception { }
        }
    }

    def change_consent(e: ChangeEvent) { consent = e.target.checked; }
    def edit_transcript(e: ChangeEvent) { draft = e.target.value; }

    def start_microphone(_e: MouseEvent) {
        if session.current or phase != "idle" { return; }
        if mode != "local" and (mode != "browser" or not consent) { return; }
        notice = "";
        draft = "";
        interim = "";
        has_transcript = False;
        phase = "starting";
        try {
            current = new_recognition(language_locale(language), mode);
            session.current = current;
            current.carebridgeHadSpeech = False;
            current.carebridgeHadError = False;
            current.onstart = lambda {
                if alive.current and session.current == current { phase = "recording"; }
            };
            current.onresult = lambda (event: any) {
                if alive.current and session.current == current {
                    final_text: str = "";
                    interim_text: str = "";
                    for i in range(int(event.results.length)) {
                        item = event.results[i];
                        if item.isFinal { final_text = final_text + " " + str(item[0].transcript); }
                        else { interim_text = interim_text + " " + str(item[0].transcript); }
                    }
                    draft = final_text.strip();
                    interim = interim_text.strip();
                    if final_text.strip() { has_transcript = True; current.carebridgeHadSpeech = True; }
                    notice = "review";
                }
            };
            current.onerror = lambda (event: any) {
                if alive.current and session.current == current {
                    current.carebridgeHadError = True;
                    notice = recognition_error(str(event.error));
                    if str(event.error) == "language-not-supported" { mode = "language_unavailable"; }
                    interim = "";
                    # Keep the session until onend so it cannot be restarted
                    # while the browser is still releasing the microphone.
                }
            };
            current.onend = lambda {
                if alive.current and session.current == current {
                    if not current.carebridgeHadSpeech and not current.carebridgeHadError { notice = "no_speech"; }
                    session.current = None;
                    phase = "idle";
                    interim = "";
                }
            };
            # This is the only path that starts recognition. It is reached by
            # a deliberate button press, after external-processing consent.
            current.start();
        } except Exception {
            current = session.current;
            session.current = None;
            if current {
                try { current.abort(); } except Exception { }
            }
            phase = "idle";
            notice = "speech_error";
        }
    }

    def stop_microphone(_e: MouseEvent) {
        current = session.current;
        if not current { return; }
        phase = "stopping";
        try { current.stop(); }
        except Exception {
            session.current = None;
            try { current.abort(); } except Exception { }
            phase = "idle";
            interim = "";
            notice = "speech_error";
        }
    }

    def use_transcript(_e: MouseEvent) {
        if phase != "idle" or not draft.strip() { return; }
        # JS callbacks stored in props use .call at the browser boundary.
        callback: any = onTranscript;
        callback.call(None, draft.strip());
        draft = "";
        has_transcript = False;
        notice = "added";
    }

    def discard_transcript(_e: MouseEvent) {
        if phase != "idle" { return; }
        draft = "";
        interim = "";
        has_transcript = False;
        notice = "";
    }

    return <section lang={language_locale(language)} aria-label={voice_label(language, "voice_input")} className="flex flex-col gap-3 rounded-lg border bg-muted/20 p-3">
        <p className="text-sm font-medium">{voice_label(language, "voice_input")}</p>
        {if mode == "checking" {
            <p role="status" className="text-xs leading-5">{voice_label(language, "checking")}</p>
        } elif mode == "local" or mode == "browser" {
            <p className="text-xs leading-5 text-muted-foreground">{voice_label(language, "local_notice" if mode == "local" else "browser_notice")}</p>
            {if mode == "browser" {
                <label className="flex items-start gap-2 text-xs leading-5">
                    <input type="checkbox" checked={consent} onChange={change_consent} disabled={phase != "idle"} className="mt-1" />
                    <span>{voice_label(language, "consent")}</span>
                </label>
            }}
            <div className="flex flex-wrap gap-2">
                <Button type="button" variant="outline" onClick={start_microphone} disabled={phase != "idle" or (mode == "browser" and not consent) or has_transcript}>{voice_label(language, "start")}</Button>
                <Button type="button" variant="outline" onClick={stop_microphone} disabled={phase == "idle" or phase == "stopping"}>{voice_label(language, "stop_recording")}</Button>
            </div>
        } else {
            <p role="status" className="text-xs leading-5">{voice_label(language, mode)}</p>
        }}
        {if phase != "idle" { <p role="status" className="text-sm">{voice_label(language, phase)}</p> }}
        {if interim { <p className="text-sm italic text-muted-foreground">{interim}</p> }}
        {if notice { <p role="status" className="text-xs leading-5">{voice_label(language, notice)}</p> }}
        {if has_transcript {
            <label htmlFor="voice-transcript" className="text-sm font-medium">{voice_label(language, "transcript")}</label>
            <Textarea id="voice-transcript" lang={language_locale(language)} value={draft} onChange={edit_transcript} disabled={phase != "idle"} className="min-h-24 bg-background" />
            <div className="flex flex-wrap gap-2">
                <Button type="button" variant="outline" onClick={use_transcript} disabled={phase != "idle" or not draft.strip()}>{voice_label(language, "use_transcript")}</Button>
                <Button type="button" variant="ghost" onClick={discard_transcript} disabled={phase != "idle"}>{voice_label(language, "discard")}</Button>
            </div>
        }}
    </section>;
}
