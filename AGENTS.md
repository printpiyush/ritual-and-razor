# Salon Queue Management

Queue app for a salon: customers join from their phone, see their wait, get called, and staff manage the queue across reception, barber, and TV views.

## Read first

- `docs/01-brief.md` -> product purpose, scope, features, and what not to build
- `docs/02-screens.md` -> all seven screens, layouts, behavior, and responsive expectations
- `docs/03-flows-rules.md` -> user flows, queue rules, edge cases, and test checklist

## Stack and run command

- Stack: React + Vite + Tailwind CSS.
- Run: `npm run dev`.
- Use the simplest storage that keeps phone, tablet, and TV views in sync; explain the choice before implementing it.
- Hosting target: Vercel for the frontend; Render or Railway only if a backend is needed.
- The live link must be the first line after the title in `README.md`; list the staff test PIN below it.

## Working rules

- Build one screen or feature per task. Do not change unrelated screens.
- Theme: charcoal `#1F2937` with gold `#D4A017`, clean rounded cards, mobile-first.
- Route every visible label through the English/Gujarati language file; do not hard-code UI copy.
- Keep queue rules in one shared place and reuse them everywhere.
- Never add features from the Don't build list in `docs/01-brief.md`.
- After each task, list changed files and how to test the change.
