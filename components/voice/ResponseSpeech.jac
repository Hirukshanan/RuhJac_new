import from "react" { useEffect }
import from ...lib.languages { language_locale, voice_label }
import from ...lib.browserSpeech { local_speech_voice, speak_reply, stop_reply, release_reply }
import from ..ui.button { Button }

# Reusable controls for one visible reply, not a conversation-wide reader.
def:pub ResponseSpeech(language: str, text: str) -> JsxElement {
    has voice_available: bool = False;
    has speaking: bool = False;
    has failed: bool = False;
    has utterance: Ref[any] = Ref(None);

    useEffect(lambda {
        synthesis = globalThis.speechSynthesis;
        def refresh_voices() {
            voice_available = bool(local_speech_voice(language_locale(language)));
        }
        refresh_voices();
        if synthesis { synthesis.addEventListener("voiceschanged", refresh_voices); }
        return lambda {
            if synthesis { synthesis.removeEventListener("voiceschanged", refresh_voices); }
            current = utterance.current;
            utterance.current = None;
            if current {
                current.onend = None;
                current.onerror = None;
                try { stop_reply(current); } except Exception { }
            }
        };
    }, [language, text]);

    def listen(_e: MouseEvent) {
        synthesis = globalThis.speechSynthesis;
        voice = local_speech_voice(language_locale(language));
        if not synthesis or not voice or not text.strip() {
            voice_available = False;
            return;
        }
        try {
            # Cancel any earlier reply. Never queue the whole conversation.
            current: any = new(globalThis.SpeechSynthesisUtterance as any, text);
            current.lang = str(voice.lang);
            current.voice = voice;
            utterance.current = current;
            current.onend = lambda {
                release_reply(current);
                if utterance.current == current { utterance.current = None; speaking = False; }
            };
            current.onerror = lambda (event: any) {
                release_reply(current);
                if utterance.current == current {
                    utterance.current = None;
                    speaking = False;
                    failed = str(event.error) != "canceled" and str(event.error) != "interrupted";
                }
            };
            failed = False;
            speaking = True;
            speak_reply(current);
        } except Exception {
            current = utterance.current;
            if current {
                try { stop_reply(current); } except Exception { }
            }
            utterance.current = None;
            speaking = False;
            failed = True;
        }
    }

    def stop(_e: MouseEvent) {
        current = utterance.current;
        utterance.current = None;
        if current {
            current.onend = None;
            current.onerror = None;
            try { stop_reply(current); } except Exception { }
        }
        speaking = False;
    }

    return <div lang={language_locale(language)} className="flex flex-col gap-2">
        <div className="flex flex-wrap gap-2">
            <Button type="button" variant="outline" onClick={listen} disabled={not voice_available or speaking}>{voice_label(language, "listen")}</Button>
            <Button type="button" variant="ghost" onClick={stop} disabled={not speaking}>{voice_label(language, "stop")}</Button>
        </div>
        <p role="status" className="text-xs leading-5 text-muted-foreground">{voice_label(language, "speaking" if speaking else ("local_output" if voice_available else "speech_unavailable"))}</p>
        {if failed { <p role="status" className="text-xs leading-5">{voice_label(language, "playback_error")}</p> }}
    </div>;
}
