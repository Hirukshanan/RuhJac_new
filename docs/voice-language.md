# Voice and language support

All feature code and translated UI copy are authored in Jac. No additional
speech package, paid provider, API key, or backend endpoint was added.

- `lib/languages.jac`: English, Sinhala and Tamil UI copy and `en-LK`, `si-LK`,
  `ta-LK` locales. Existing language values are preserved for the handover.
- `lib/browserSpeech.jac`: browser Web Speech API boundary, optional language
  availability probe, matching local voices, and playback ownership.
- `components/voice/VoiceInput.jac`: deliberate microphone start/stop, external
  processing consent, errors, and editable transcript review.
- `components/voice/ResponseSpeech.jac`: Listen/Stop controls for one reply.
- `components/CareBridgeWorkspace.jac`: small integration with the existing
  concern field, language selector, prompt, and confirmation message.

Dictation requires a deliberate Start microphone press. If on-device language
recognition is reported as installed, recognition is explicitly set to local
processing. Otherwise a notice and unchecked consent box explain that the
browser may send audio to an external speech service. The browser handles the
microphone permission request when recognition starts. Optional availability
queries do not start recording or install language packs. Older browsers cannot
reliably preflight remote language support; the UI says so and handles runtime
language errors. Text entry remains available in all cases.

Only final recognition results become an editable transcript. The user must
review it and press Add reviewed text to my message to copy it to the existing
concern field. The existing Prepare my story action remains a separate step.
CareBridge does not record audio blobs, upload audio itself, or persist speech
text outside the existing in-memory session. External browser speech services
have their own data policies; the notice does not promise their retention rules.
Changing language or unmounting aborts recognition and stops owned playback.
Unapplied transcript drafts are discarded when changing language; text already
added to the concern field stays editable.

Listen reads only the displayed reply selected by the user. Only voices marked
`localService` for the selected language are used, preferring the exact locale
and then the same base language. Remote voices and voices in a different
language are excluded. Missing voices produce a text explanation, with the
original reply still visible. Voice lists refresh on `voiceschanged`.

This prototype has a concern/story interface rather than a chatbot thread.
Listen is attached to the localized app prompt and handover confirmation; the
reusable component can be attached to future individual replies. Patient text,
summary headings, facility information, and medical source text are not machine
translated. The UI explicitly says translations are not clinically validated.

The installed Jac 0.37.25 required compatibility updates to `jac.toml` (module
entry point, Python dev-dependency table, removal of disabled legacy scale
configuration) and removal of the old `sv` import marker. The current CLI uses
`jac run --dev main.jac`; the starter's `jac start` command has been removed.

## Verification status

Implementation only: checks and runtime/browser verification were deferred at
the user's request. No recognition, permission, playback, or language capability
has been verified in the running app. The next pass should run `jac check` and
the app, then test each language with speech APIs absent, permission allowed and
denied, transcript correction, explicit submission, playback start/stop,
language switching, missing voices, and browser speech errors. Use synthetic
patient examples and distinguish real microphone tests from mocked API tests.

Browser API references:

- [Speech recognition availability](https://developer.mozilla.org/en-US/docs/Web/API/SpeechRecognition/available_static)
- [Local recognition processing](https://developer.mozilla.org/en-US/docs/Web/API/SpeechRecognition/processLocally)
- [Local synthesis voices](https://developer.mozilla.org/en-US/docs/Web/API/SpeechSynthesisVoice/localService)
