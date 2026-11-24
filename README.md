# Salon Queue Management System

**Live demo:** https://ritual-and-razor.vercel.app

**Staff PIN:** `2468` for `/reception`, `/barber/Raj` (or `/barber/Kishan`, `/barber/Hitesh`), and `/admin`.

**Hosted on:** Vercel (frontend)

## About

A live salon queue for customers, reception, barbers, and the waiting-area TV. Customers join from a phone, see their token and wait, and get called when it is their turn. Reception manages walk-ins and the waiting list, barbers start and finish services, and the TV shows who is being served and who is next.

Built with React + Vite + Tailwind CSS.

## Screens

| Screen | Route | Who uses it |
| --- | --- | --- |
| Home | `/` | Customers |
| Join Queue | `/join` | Customers |
| My Status | `/status/:id` | Customers |
| Reception Dashboard | `/reception` | Receptionist / owner |
| Barber View | `/barber/:name` | Raj, Kishan, Hitesh |
| Waiting Area TV | `/display` | Waiting-area audience |
| Owner Settings | `/admin` | Owner |

## Run locally

```bash
npm install
npm run dev
```

Open the printed local URL. To test the multi-view sync, open the same URL in separate browser windows.

## Build

```bash
npm run build
npm run preview
```

## Storage and sync

The app uses `localStorage` as the single shared store and `BroadcastChannel` (plus the `storage` event as a fallback) to sync open views instantly. This keeps the demo zero-setup and works across separate browser windows on the same browser profile. It does **not** sync across different devices; a hosted realtime store would be needed for that.

## Queue rules

- Statuses: `Waiting -> Called -> In chair -> Done`, plus `Waiting -> Cancelled` and `Called -> No-show`.
- First come, first served.
- **Call next** picks the earliest waiting customer who chose that barber or chose **Any barber**.
- A customer who chose Raj is never assigned to Kishan or Hitesh, and the same rule applies to the other barbers.
- One active spot per phone number; joining again opens the existing spot.
- A barber has one customer in the chair at a time.
- Wait estimate = service minutes ahead ÷ working, eligible barbers.
- Waiting longer than 60 minutes should be highlighted in amber.
- No-show is allowed after the 10-minute grace period.
- Online joining closes 30 minutes before closing; walk-ins remain available.

## Staff access

The staff screens (`/reception`, `/barber/:name`, `/admin`) are protected by a demo PIN:

```text
2468
```

This is a client-side demo gate, not production authentication.

## Deploy to Vercel

1. Push this repository to GitHub.
2. Import the repository at [vercel.com](https://vercel.com).
3. Vercel auto-detects Vite. Build command: `npm run build`; output directory: `dist`.
4. Deploy. `vercel.json` rewrites all routes to `index.html`, so refreshing `/status/S-14` or `/reception` does not 404.
5. Deploy. `vercel.json` rewrites all routes to `index.html`, so refreshing `/status/S-14` or `/reception` does not 404.
6. Re-deploy after any change (`npx vercel --prod` or a push to the linked GitHub repo).

## Project structure

```text
docs/                  Brief, screens, flows and rules
src/main.jsx           All seven screens, shared queue logic, EN/GU labels
src/styles.css         Tailwind entry, theme helpers, gold pulse animation
AGENTS.md              Agent working rules
prompts.md             Prompts used in this session
reflection.md          Half-page reflection for submission
vercel.json            SPA route rewrites
```

## Known limitations

- Sync uses the browser's `localStorage`, so it works across tabs/windows of the same browser profile but **not across separate phones/tablets**. A hosted realtime store (e.g. Firebase or Supabase) would be needed for cross-device sync.
- Staff PIN is a client-side demo gate, not production authentication.
- TV chime is not implemented; the called token card flashes gold instead.
- Average wait is a seeded demo value and does not recompute from history.
