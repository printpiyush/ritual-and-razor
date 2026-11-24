# Ritual & Razor
### Salon Queue Management System

**Live demo:** [ritual-and-razor.vercel.app](https://ritual-and-razor.vercel.app)  
**Staff test PIN:** `2468` — `/reception`, `/barber/Raj`, `/barber/Kishan`, `/barber/Hitesh`, `/admin`  
**Hosting:** Vercel · **Data & realtime:** Supabase

<p>
  <img alt="React" src="https://img.shields.io/badge/React-UI-20232A?logo=react&logoColor=61DAFB">
  <img alt="Vite" src="https://img.shields.io/badge/Vite-build-646CFF?logo=vite&logoColor=white">
  <img alt="Tailwind CSS" src="https://img.shields.io/badge/Tailwind-CSS-06B6D4?logo=tailwindcss&logoColor=white">
  <img alt="Supabase" src="https://img.shields.io/badge/Supabase-realtime-3FCF8E?logo=supabase&logoColor=white">
  <img alt="Vercel" src="https://img.shields.io/badge/Deployed-Vercel-black?logo=vercel&logoColor=white">
</p>

> A calm, premium queue experience for customers and a shared operating view for the salon team.

---

## Overview

Ritual & Razor replaces an informal waiting line with a token-based salon queue. Customers can join online, select services and a preferred barber, and follow their status. Reception manages walk-ins and assignments, barbers update service progress, and a waiting-area display keeps the next customers informed.

The interface uses a charcoal-and-gold visual system and supports English and Gujarati labels.

## The experience

| Surface | Route | Primary user | Purpose |
|---|---|---|---|
| Home | `/` | Customer | Salon status, waiting count, barber availability |
| Join Queue | `/join` | Customer | Contact details, services, barber preference |
| My Status | `/status/:token` | Customer | Token, position, estimated wait, called state |
| Reception | `/reception` | Reception / owner | Walk-ins, assignments, waiting list, no-shows |
| Barber View | `/barber/:name` | Barber | Start and complete the current service |
| Waiting Area TV | `/display` | Salon visitors | Current barber assignments and next five tokens |
| Owner Settings | `/admin` | Owner | Service availability, barber duty, online queue |

## Capabilities

- **Customer joining:** validates a name, a 10-digit phone number, at least one service, and a maximum of three services.
- **Service summary:** calculates the selected services' combined price and duration.
- **Barber preference:** supports Any barber, Raj, Kishan, or Hitesh.
- **Queue status:** issues tokens, shows waiting position and an approximate wait, and highlights the second-in-line state.
- **Reception operations:** adds walk-ins, calls the next eligible customer, and handles cancellation and no-show actions.
- **Barber workflow:** moves a called customer to In chair, then Done; barbers can toggle availability when their chair is empty.
- **Owner controls:** opens/closes online joining, enables/disables services, and toggles the barber duty roster.
- **Shared state:** persists the application state in Supabase and receives database updates through Supabase Realtime.
- **Local fallback:** caches state in the browser and uses `BroadcastChannel` / the `storage` event for same-browser tab synchronization.
- **Language:** English and Gujarati labels are provided for the main application UI. The TV display currently has no separate language toggle.

## Technology

| Layer | Implementation |
|---|---|
| UI | React |
| Development and build | Vite |
| Styling | Tailwind CSS with project-specific theme tokens |
| Shared persistence | Supabase Postgres (`public.salon_state`) |
| Live updates | Supabase Realtime (`postgres_changes`) |
| Local cache / tab fallback | `localStorage`, `BroadcastChannel`, `storage` event |
| Hosting | Vercel |

### How shared state works

The current app stores its existing state object as JSON in one row of `public.salon_state` (`id = 1`). This approach kept the existing React state model intact while adding shared persistence and realtime updates.

1. The app loads the singleton state row from Supabase.
2. UI actions update the React state.
3. The updated state is cached locally and upserted to Supabase.
4. Other connected app instances receive the row update through Supabase Realtime.
5. If Supabase configuration or initialization is unavailable, the browser-local cache remains the fallback; that fallback does not provide cross-device synchronization.

See [`docs/04-architecture.md`](docs/04-architecture.md) for the data flow and setup notes.

## Run locally

### Requirements

- Node.js and npm
- A Supabase project for shared, cross-device state

### 1. Install dependencies

```bash
npm install
```

### 2. Configure Supabase

Copy `.env.example` to `.env` and add the project URL and **publishable** key from your Supabase project:

```env
VITE_SUPABASE_URL=https://YOUR_PROJECT_REF.supabase.co
VITE_SUPABASE_PUBLISHABLE_KEY=sb_publishable_YOUR_KEY
```

Run the SQL in [`supabase/salon_state_setup.sql`](supabase/salon_state_setup.sql) in the Supabase SQL Editor. The application expects the `public.salon_state` singleton row/table and Realtime publication described there.

Do not put a Supabase `service_role` or secret key in a Vite environment variable. Vite `VITE_` variables are bundled into the browser application.

### 3. Start the development server

```bash
npm run dev
```

Open the local URL printed by Vite. For a sync smoke test, open the app in two separate browser contexts and perform a queue action in one.

### 4. Build and preview

```bash
npm run build
npm run preview
```

## Deployment

The production frontend is hosted on Vercel.

- **Build command:** `npm run build`
- **Output directory:** `dist`
- **SPA routing:** `vercel.json` rewrites app routes to `index.html`, so deep links such as `/status/S-14` can load through the React app.
- **Environment variables:** configure `VITE_SUPABASE_URL` and `VITE_SUPABASE_PUBLISHABLE_KEY` for the Vercel Production environment, then redeploy.

To deploy from a local checkout with the Vercel CLI:

```bash
npx vercel --prod
```

## Repository map

```text
.
├── docs/
│   ├── 01-brief.md
│   ├── 02-screens.md
│   ├── 03-flows-rules.md
│   ├── 04-architecture.md
│   └── 05-verification.md
├── src/
│   ├── main.jsx           # Screens, queue actions, and shared React state
│   ├── supabase.js        # Supabase client configuration
│   └── styles.css         # Global styles, typography, and visual effects
├── supabase/
│   └── salon_state_setup.sql
├── AGENTS.md
├── prompts.md
├── reflection.md
├── .env.example
└── vercel.json
```

## Verification snapshot

The following checks were confirmed during the project session on **24 November 2026**:

| Check | Result | Evidence |
|---|---|---|
| Production site opens | Pass | Live URL opened successfully |
| Supabase client initializes | Pass | Browser console reported the database connection |
| Database persistence | Pass | Test customer changed the `salon_state` row and its `updated_at` value |
| Separate browser contexts | Pass | A Chrome update appeared in an Incognito window without refresh |
| Phone ↔ desktop realtime | Pass | A queue removal on mobile updated the desktop view |
| Production build | Pass | `npm run build` completed successfully on the project machine after Supabase integration |

The remaining UI and edge-case checks are listed in [`docs/05-verification.md`](docs/05-verification.md). A source-code review is not a substitute for manually testing every interaction.

## Known limitations

This is a **vibe-coding lab/demo project**, not a production-ready salon platform.

- The staff PIN (`2468`) is checked in client-side code and stored in `sessionStorage`. It is a demonstration gate, not secure authentication.
- The supplied demo SQL grants the Supabase `anon` role broad read/write access to the singleton state row so the public demo can sync without sign-in. That row contains customer phone fields. **Use synthetic/test data only. Do not store real customer information with this policy.**
- The Admin screen can enable/disable services and toggle barber duty; it does not currently edit service prices or durations.
- The average-wait statistic is seeded demo data and is not recalculated from completed appointments.
- The TV display flashes the called token in gold; an audible chime is not implemented.
- The TV display uses barber initials rather than uploaded barber photos and has no independent language toggle.
- The Join Queue form checks for an existing active phone number. The receptionist walk-in form does not currently apply the same duplicate-phone check.
- The application writes the whole state object to one JSONB row. This is simple for a classroom prototype but is not a transactional, multi-tenant queue architecture.

Before real-world use, add authenticated staff access, restrictive row-level security, server-side validation, proper customer-data protection, conflict-safe queue operations, and an audited database model.

## Project documents

- [Project brief](docs/01-brief.md)
- [Screens and features](docs/02-screens.md)
- [Flows, rules, and test checklist](docs/03-flows-rules.md)
- [Technical architecture](docs/04-architecture.md)
- [Verification record](docs/05-verification.md)
- [Three-minute demo runbook](docs/06-demo-script.md)
- [Prompt log](prompts.md)
- [Reflection](reflection.md)
