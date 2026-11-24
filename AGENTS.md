# AGENTS.md · Ritual & Razor

Ritual & Razor is a React-based salon queue prototype. Customers join a live queue; reception, barbers, and the waiting-area display share the same queue state.

## Read before changing code

1. `docs/01-brief.md` — product purpose, scope, and non-goals.
2. `docs/02-screens.md` — screen responsibilities, routes, controls, and responsive behavior.
3. `docs/03-flows-rules.md` — queue transitions, assignment rules, estimates, and edge cases.
4. `docs/04-architecture.md` — state persistence, Supabase Realtime, environment variables, and security boundaries.
5. `docs/05-verification.md` — what has actually been checked and what remains unverified.

## Stack

- React + Vite
- Tailwind CSS + project-specific CSS
- Supabase JS client
- Supabase Postgres singleton row: `public.salon_state`
- Supabase Realtime for cross-device updates
- Vercel for the production frontend

Commands:

```bash
npm install
npm run dev
npm run build
npm run preview
```

## Product and visual rules

- Preserve the charcoal `#1F2937`, gold `#D4A017`, cream `#F8F5ED`, and ink `#111827` palette.
- Keep the interface mobile-first, with clear hierarchy and tap targets of at least 44px.
- Keep English and Gujarati copy paired when changing shared UI labels.
- Keep the seven route responsibilities aligned with `docs/02-screens.md`.
- Preserve the existing state shape unless a migration is explicitly planned.
- Queue state is currently stored as one JSONB object in `public.salon_state`; do not silently introduce a second source of truth.

## Implementation rules

- Make one focused change at a time; avoid unrelated screen rewrites.
- Read the relevant docs and inspect the existing implementation before changing behavior.
- Keep queue rules centralized and consistent across screens.
- Do not add features listed under non-goals in `docs/01-brief.md`.
- Never commit `.env`, Supabase secret/service-role keys, real customer data, build output, or local backups.
- The browser publishable key is public by design; security depends on database policies. The supplied anonymous demo policy is not suitable for real customer records.
- Do not describe the demo PIN as authentication.
- Do not claim a test passed unless it was actually run. Separate code inspection from manual verification.

## Definition of done

For each change:

1. List the files changed and explain why.
2. Run `npm run build` when dependencies are available.
3. Manually test the affected route and a related cross-screen flow.
4. Update the matching document and `docs/05-verification.md`.
5. Report any unverified behavior or remaining limitation.
