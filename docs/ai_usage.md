# AI usage log

The course allows AI for brainstorming, explanation, language improvement and debugging suggestions, and requires us to disclose it. Each row records what the AI did and what we did or checked ourselves. The report's AI disclosure is written from this log.

| Date | Tool | What the AI did | What we did / checked |
|---|---|---|---|
| 2026-11-16 | Claude (Claude Code) | Read the project handbook and proposed a two-week plan. Moved the lab sources (`Node3.cc`, `DiffuseMessage.msg`, `Network3.ned`) into the repository unchanged, and wrote the `Makefile`, `.gitignore` and the README build section. Listed defects in `Node3.cc`. Drafted a step-by-step roadmap. | Ran the build and the reference simulation ourselves and confirmed the lab result: 10 messages, last event at t = 0.4 s. |
| 2026-11-17 | Claude (Claude Code) | Wrote the README Team section and project layout, and started this log. Drafted English speaker notes for student B's parts of the talk (language help). | Chose the A/B/C role split. The speaker notes will be checked against our real results before the talk. |
| 2026-11-21 | Claude (Claude Code) | Wrote the validation networks V3 Tree7, V4 Ring4, V5 Cyclic6, V7 Gaps and the INI configs V3–V7 (V6 reuses Line6 with initiators 0, 2 and 5). Wrote the hand traces in `tests/hand_traces.md`, filled in the expected values and added `scripts/run_validation.sh`. Diagnosed the first failed run (results were written flat instead of in one folder per config) and set `result-dir` in `omnetpp.ini`. | Ran the suite on OMNeT++ 6.4.0: all of V1–V7 match the expected values. To do: check each hand trace ourselves. |
