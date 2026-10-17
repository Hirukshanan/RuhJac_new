# UI copy only. This does not translate patient stories or medical source text.
# Keep the existing English/Sinhala/Tamil values used by the handover interface.
glob LANGUAGE_LOCALES: dict[str, str] = {
    "English": "en-LK", "Sinhala": "si-LK", "Tamil": "ta-LK"
};

glob LANGUAGE_COPY: dict[str, dict[str, str]] = {
    "English": {
        "language": "Language",
        "voice_input": "Voice input (optional)",
        "start": "Start microphone",
        "stop_recording": "Stop microphone",
        "starting": "Requesting microphone permission…",
        "recording": "Microphone is on. Speak, then press Stop microphone.",
        "stopping": "Finishing transcription…",
        "checking": "Checking speech support for this language…",
        "local_notice": "Speech recognition will run on this device. Press Start microphone to request microphone permission. CareBridge does not save raw audio.",
        "browser_notice": "Your browser controls speech recognition and may send health-related audio to its vendor's external speech service. CareBridge cannot verify that service's retention policy or language support. CareBridge does not save raw audio. Text entry is always available.",
        "consent": "I understand and agree to my browser processing my audio, which may include sending it to an external speech service.",
        "unavailable": "Speech recognition is unavailable in this browser. Please type your message.",
        "insecure": "The microphone requires HTTPS or localhost. Please type your message here.",
        "language_unavailable": "Speech recognition is unavailable for this language in this browser. Please type your message.",
        "denied": "Microphone access was denied. You can allow it in browser settings, or keep typing.",
        "audio_error": "The microphone could not be opened. Check your device or keep typing.",
        "network_error": "The browser's speech service could not be reached. Try again or type your message.",
        "speech_error": "Speech recognition stopped with an error. Try again or type your message.",
        "no_speech": "No speech was recognised. Try again or type your message.",
        "review": "Review and correct the transcript below. Nothing is sent automatically.",
        "transcript": "Editable transcript",
        "use_transcript": "Add reviewed text to my message",
        "discard": "Discard transcript",
        "added": "Transcript added to your editable message. Review it, then press Prepare my story when ready.",
        "listen": "Listen",
        "stop": "Stop",
        "speaking": "Reading this response aloud…",
        "speech_unavailable": "Spoken output is unavailable for this language: no matching on-device voice is available. You can still read the response.",
        "playback_error": "Spoken output could not play. The text response is still available.",
        "local_output": "Listen uses an on-device voice for this language. Only this response is read aloud.",
        "scope": "Language selection applies to voice controls and the prompts shown here. Patient details and medical sources are not translated. These translations have not been clinically validated.",
        "prompt": "Describe your concern in your own words. Review and correct your story before confirming it.",
        "confirmed_reply": "Your reviewed handover is ready to download. It has not been sent to anyone."
    },
    "Sinhala": {
        "language": "භාෂාව",
        "voice_input": "හඬින් ඇතුළත් කිරීම (විකල්පයි)",
        "start": "මයික්‍රෆෝනය අරඹන්න",
        "stop_recording": "මයික්‍රෆෝනය නවත්වන්න",
        "starting": "මයික්‍රෆෝන අවසරය ඉල්ලමින්…",
        "recording": "මයික්‍රෆෝනය ක්‍රියාත්මකයි. කතා කර අවසන් වූ පසු නවත්වන්න.",
        "stopping": "හඬ පෙළට හැරවීම අවසන් කරමින්…",
        "checking": "මෙම භාෂාව සඳහා හඬ සහාය පරීක්ෂා කරමින්…",
        "local_notice": "හඬ හඳුනාගැනීම මෙම උපාංගයේ සිදු වේ. මයික්‍රෆෝන අවසරය ඉල්ලීමට ආරම්භ බොත්තම ඔබන්න. CareBridge මුල් හඬ පටිගත කිරීම් සුරකින්නේ නැත.",
        "browser_notice": "ඔබගේ බ්‍රවුසරය හඬ හඳුනාගැනීම පාලනය කරයි. සෞඛ්‍ය තොරතුරු ඇතුළත් හඬ එහි සැපයුම්කරුගේ බාහිර හඬ සේවාවකට යැවිය හැක. එම සේවාවේ දත්ත රඳවාගැනීම හෝ භාෂා සහාය CareBridge හට තහවුරු කළ නොහැක. CareBridge මුල් හඬ සුරකින්නේ නැත. ඔබට සෑම විටම ටයිප් කළ හැක.",
        "consent": "මගේ බ්‍රවුසරය මගේ හඬ සැකසීමටත්, අවශ්‍ය නම් බාහිර හඬ සේවාවකට යැවීමටත් මම දැනුවත්ව එකඟ වෙමි.",
        "unavailable": "මෙම බ්‍රවුසරයේ හඬ හඳුනාගැනීම නොමැත. ඔබගේ පණිවිඩය ටයිප් කරන්න.",
        "insecure": "මයික්‍රෆෝනයට HTTPS හෝ localhost අවශ්‍යයි. මෙහි ඔබගේ පණිවිඩය ටයිප් කරන්න.",
        "language_unavailable": "මෙම බ්‍රවුසරයේ මෙම භාෂාව සඳහා හඬ හඳුනාගැනීම නොමැත. ඔබගේ පණිවිඩය ටයිප් කරන්න.",
        "denied": "මයික්‍රෆෝන අවසරය ප්‍රතික්ෂේප විය. බ්‍රවුසර සැකසුම්වලින් අවසර දෙන්න, නැතහොත් ටයිප් කරන්න.",
        "audio_error": "මයික්‍රෆෝනය විවෘත කළ නොහැකි විය. උපාංගය පරීක්ෂා කරන්න හෝ ටයිප් කරන්න.",
        "network_error": "බ්‍රවුසරයේ හඬ සේවාවට සම්බන්ධ විය නොහැකි විය. නැවත උත්සාහ කරන්න හෝ ටයිප් කරන්න.",
        "speech_error": "දෝෂයක් නිසා හඬ හඳුනාගැනීම නැවතිණි. නැවත උත්සාහ කරන්න හෝ ටයිප් කරන්න.",
        "no_speech": "හඬක් හඳුනාගත නොහැකි විය. නැවත උත්සාහ කරන්න හෝ ටයිප් කරන්න.",
        "review": "පහත පෙළ කියවා නිවැරදි කරන්න. කිසිවක් ස්වයංක්‍රීයව යවන්නේ නැත.",
        "transcript": "සංස්කරණය කළ හැකි හඬ පෙළ",
        "use_transcript": "සමාලෝචිත පෙළ මගේ පණිවිඩයට එක් කරන්න",
        "discard": "හඬ පෙළ ඉවත් කරන්න",
        "added": "හඬ පෙළ ඔබගේ සංස්කරණය කළ හැකි පණිවිඩයට එක් කළා. එය සමාලෝචනය කර සූදානම් වූ විට Prepare my story ඔබන්න.",
        "listen": "සවන් දෙන්න",
        "stop": "නවත්වන්න",
        "speaking": "මෙම ප්‍රතිචාරය හඬින් කියවමින්…",
        "speech_unavailable": "මෙම භාෂාවට ගැළපෙන උපාංගයේ හඬක් නොමැති නිසා හඬින් කියවීම ලබාගත නොහැක. ප්‍රතිචාරය කියවිය හැක.",
        "playback_error": "හඬින් කියවීමට නොහැකි විය. පෙළ ප්‍රතිචාරය තවමත් ඇත.",
        "local_output": "සවන් දීම සඳහා මෙම භාෂාවට ගැළපෙන උපාංගයේ හඬක් භාවිත වේ. මෙම ප්‍රතිචාරය පමණක් කියවනු ලැබේ.",
        "scope": "භාෂා තේරීම හඬ පාලන සහ මෙහි පෙන්වන උපදෙස් සඳහා යෙදේ. රෝගියාගේ තොරතුරු සහ වෛද්‍ය මූලාශ්‍ර පරිවර්තනය නොකෙරේ. මෙම පරිවර්තන සායනිකව තහවුරු කර නැත.",
        "prompt": "ඔබගේ ගැටලුව ඔබගේම වචනවලින් විස්තර කරන්න. තහවුරු කිරීමට පෙර ඔබගේ විස්තරය කියවා නිවැරදි කරන්න.",
        "confirmed_reply": "ඔබ සමාලෝචනය කළ සාරාංශය බාගත කිරීමට සූදානම්. එය කිසිවෙකුට යවා නැත."
    },
    "Tamil": {
        "language": "மொழி",
        "voice_input": "குரல் உள்ளீடு (விருப்பத்தேர்வு)",
        "start": "ஒலிவாங்கியைத் தொடங்கு",
        "stop_recording": "ஒலிவாங்கியை நிறுத்து",
        "starting": "ஒலிவாங்கி அனுமதி கோரப்படுகிறது…",
        "recording": "ஒலிவாங்கி இயங்குகிறது. பேசி முடித்ததும் நிறுத்து பொத்தானை அழுத்தவும்.",
        "stopping": "குரலை உரையாக மாற்றுவது முடிக்கப்படுகிறது…",
        "checking": "இந்த மொழிக்கான குரல் ஆதரவு சரிபார்க்கப்படுகிறது…",
        "local_notice": "குரல் அறிதல் இந்தச் சாதனத்திலேயே நடைபெறும். ஒலிவாங்கி அனுமதி கோர தொடங்கு பொத்தானை அழுத்தவும். CareBridge மூல ஒலிப்பதிவுகளைச் சேமிக்காது.",
        "browser_notice": "உங்கள் உலாவி குரல் அறிதலைக் கட்டுப்படுத்துகிறது. உடல்நலத் தகவல் உள்ள ஒலியை அதன் வழங்குநரின் வெளிப்புறக் குரல் சேவைக்கு அனுப்பக்கூடும். அந்தச் சேவையின் தரவுத் தக்கவைப்பு அல்லது மொழி ஆதரவை CareBridge உறுதிப்படுத்த முடியாது. CareBridge மூல ஒலியைச் சேமிக்காது. நீங்கள் எப்போதும் தட்டச்சு செய்யலாம்.",
        "consent": "எனது உலாவி எனது ஒலியைச் செயலாக்கவும், தேவைப்பட்டால் வெளிப்புறக் குரல் சேவைக்கு அனுப்பவும் நான் அறிந்து ஒப்புக்கொள்கிறேன்.",
        "unavailable": "இந்த உலாவியில் குரல் அறிதல் கிடைக்கவில்லை. உங்கள் செய்தியைத் தட்டச்சு செய்யவும்.",
        "insecure": "ஒலிவாங்கிக்கு HTTPS அல்லது localhost தேவை. இங்கே உங்கள் செய்தியைத் தட்டச்சு செய்யவும்.",
        "language_unavailable": "இந்த உலாவியில் இந்த மொழிக்குக் குரல் அறிதல் கிடைக்கவில்லை. உங்கள் செய்தியைத் தட்டச்சு செய்யவும்.",
        "denied": "ஒலிவாங்கி அனுமதி மறுக்கப்பட்டது. உலாவி அமைப்புகளில் அனுமதிக்கலாம் அல்லது தட்டச்சு செய்யலாம்.",
        "audio_error": "ஒலிவாங்கியைத் திறக்க முடியவில்லை. சாதனத்தைச் சரிபார்க்கவும் அல்லது தட்டச்சு செய்யவும்.",
        "network_error": "உலாவியின் குரல் சேவையை அணுக முடியவில்லை. மீண்டும் முயலவும் அல்லது தட்டச்சு செய்யவும்.",
        "speech_error": "பிழையால் குரல் அறிதல் நிறுத்தப்பட்டது. மீண்டும் முயலவும் அல்லது தட்டச்சு செய்யவும்.",
        "no_speech": "பேச்சு எதுவும் அறியப்படவில்லை. மீண்டும் முயலவும் அல்லது தட்டச்சு செய்யவும்.",
        "review": "கீழுள்ள உரையைப் படித்துத் திருத்தவும். எதுவும் தானாக அனுப்பப்படாது.",
        "transcript": "திருத்தக்கூடிய குரல் உரை",
        "use_transcript": "சரிபார்த்த உரையை என் செய்தியில் சேர்",
        "discard": "குரல் உரையை நீக்கு",
        "added": "குரல் உரை உங்கள் திருத்தக்கூடிய செய்தியில் சேர்க்கப்பட்டது. சரிபார்த்து, தயாரானதும் Prepare my story பொத்தானை அழுத்தவும்.",
        "listen": "கேளுங்கள்",
        "stop": "நிறுத்து",
        "speaking": "இந்தப் பதில் வாசிக்கப்படுகிறது…",
        "speech_unavailable": "இந்த மொழிக்குப் பொருத்தமான சாதனக் குரல் இல்லாததால் குரல் வெளியீடு கிடைக்கவில்லை. பதிலை நீங்கள் படிக்கலாம்.",
        "playback_error": "குரல் வெளியீட்டை இயக்க முடியவில்லை. உரைப் பதில் தொடர்ந்து கிடைக்கும்.",
        "local_output": "கேளுங்கள் வசதி இந்த மொழிக்கான சாதனக் குரலைப் பயன்படுத்துகிறது. இந்தப் பதில் மட்டும் வாசிக்கப்படும்.",
        "scope": "மொழித் தேர்வு குரல் கட்டுப்பாடுகளுக்கும் இங்குள்ள வழிமுறைகளுக்கும் பொருந்தும். நோயாளியின் தகவல்களும் மருத்துவ ஆதாரங்களும் மொழிபெயர்க்கப்படாது. இந்த மொழிபெயர்ப்புகள் மருத்துவ ரீதியாகச் சரிபார்க்கப்படவில்லை.",
        "prompt": "உங்கள் கவலையை உங்கள் சொந்த வார்த்தைகளில் விவரிக்கவும். உறுதிப்படுத்துவதற்கு முன் உங்கள் விவரங்களைப் படித்துத் திருத்தவும்.",
        "confirmed_reply": "நீங்கள் சரிபார்த்த சுருக்கம் பதிவிறக்கத் தயாராக உள்ளது. அது யாருக்கும் அனுப்பப்படவில்லை."
    }
};

def language_locale(language: str) -> str {
    if language in LANGUAGE_LOCALES { return LANGUAGE_LOCALES[language]; }
    return "en-LK";
}

def voice_label(language: str, key: str) -> str {
    selected = language if language in LANGUAGE_COPY else "English";
    copy = LANGUAGE_COPY[selected];
    if key in copy { return copy[key]; }
    if key in LANGUAGE_COPY["English"] { return LANGUAGE_COPY["English"][key]; }
    return key;
}
