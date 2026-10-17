# Browser-only interop boundary. Web Speech has no complete Jac DOM stubs.
# All policy, state and UI remain in Jac; no audio blobs or server requests.
glob active_reply: any = None;

def recognition_constructor() -> any {
    return globalThis.SpeechRecognition or globalThis.webkitSpeechRecognition;
}

async def recognition_mode(locale: str) -> str {
    if not globalThis.isSecureContext { return "insecure"; }
    constructor = recognition_constructor();
    if not constructor { return "unavailable"; }
    if constructor.available {
        try {
            # Check installed on-device language support without recording or
            # downloading a pack. Remote language support cannot be guaranteed.
            local_status = str(await constructor.available({"langs": [locale], "processLocally": True}));
            if local_status == "available" { return "local"; }
            remote_status = str(await constructor.available({"langs": [locale], "processLocally": False}));
            if remote_status == "unavailable" { return "language_unavailable"; }
        } except Exception {
            # Older browsers and Permissions-Policy restrictions can prevent
            # this optional probe. Do not claim language support in that case.
            return "browser";
        }
    }
    return "browser";
}

def new_recognition(locale: str, mode: str) -> any {
    recognition = new(recognition_constructor());
    recognition.lang = locale;
    recognition.continuous = False;
    recognition.interimResults = True;
    recognition.maxAlternatives = 1;
    # Never silently fall back to a remote service after choosing local mode.
    recognition.processLocally = mode == "local";
    return recognition;
}

def recognition_error(code: str) -> str {
    if code == "not-allowed" or code == "service-not-allowed" { return "denied"; }
    if code == "language-not-supported" { return "language_unavailable"; }
    if code == "audio-capture" { return "audio_error"; }
    if code == "network" { return "network_error"; }
    if code == "no-speech" { return "no_speech"; }
    return "speech_error";
}

def local_speech_voice(locale: str) -> any {
    synthesis = globalThis.speechSynthesis;
    if not synthesis or not globalThis.SpeechSynthesisUtterance { return None; }
    fallback: any = None;
    voices = synthesis.getVoices() as list[any];
    for voice in voices {
        voice_locale = str(voice.lang).lower().replace("_", "-");
        if voice.localService == True {
            if voice_locale == locale.lower() { return voice; }
            if not fallback and voice_locale.split("-")[0] == locale.lower().split("-")[0] {
                fallback = voice;
            }
        }
    }
    # Deliberately exclude remote voices: no response text leaves the device
    # through this feature, and a different language is never substituted.
    return fallback;
}

def speak_reply(reply: any) {
    synthesis = globalThis.speechSynthesis;
    synthesis.cancel();
    active_reply = reply;
    synthesis.speak(reply);
}

def release_reply(reply: any) {
    if active_reply == reply { active_reply = None; }
}

def stop_reply(reply: any) {
    # An old response's cleanup must never cancel a newer response.
    if active_reply == reply {
        active_reply = None;
        globalThis.speechSynthesis.cancel();
    }
}
