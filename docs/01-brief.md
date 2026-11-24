# 01 · Project Brief
## Ritual & Razor — Salon Queue Management System

### Product summary

Ritual & Razor is a salon queue prototype that gives customers a clear token and approximate wait while providing salon staff with a shared operational view. The intended experience reduces uncertainty around queue order, barber preference, and service progress.

### Problem

At busy periods, customers may wait without knowing their position or when they will be called. Staff also need a consistent way to manage walk-ins, assign the next eligible customer, and keep the waiting area informed.

### Users and jobs to be done

| User | Primary need |
|---|---|
| Customer | Join the queue, choose services and a barber preference, and track the token |
| Receptionist / owner | Add walk-ins, call the next eligible customer, and manage queue exceptions |
| Barber | See the assigned customer, start and finish the service, and mark a break |
| Waiting-area visitor | Read the currently served tokens and the next customers |

### Core scope

1. Seven connected views: Home, Join Queue, My Status, Reception, Barber View, Waiting Area TV, and Owner Settings.
2. Customer details with a 10-digit phone check, one to three service selections, and barber preference.
3. Token issuance, queue position, approximate wait, and a second-in-line “Start coming” message.
4. Reception controls for walk-ins, Call next, cancellation, and no-show.
5. Barber controls for Start, Done, and break/available state.
6. TV display for current barber assignments and up to five waiting tokens.
7. Owner controls for online queue availability, service availability, and barber duty.
8. English and Gujarati interface copy for the main application views.
9. Shared state through Supabase Postgres and Supabase Realtime, with a browser-local fallback for same-browser use.

### Explicit non-goals

- Online payment or billing.
- Future-date appointments or calendar booking.
- SMS, WhatsApp, or push-message delivery.
- Loyalty, rewards, or membership management.
- Multiple salon branches.
- Production-grade authentication, authorization, or customer-data handling.

### Visual direction

A premium, calm salon identity built around charcoal `#1F2937`, gold `#D4A017`, cream `#F8F5ED`, and ink `#111827`. Use expressive display typography, restrained cards, readable information density, and mobile-first layouts.

### Scope clarifications

The current prototype shows service duration and price and allows services to be enabled/disabled; it does not provide price/duration editing. The average-wait metric is seeded demo data. The TV view highlights a newly called token visually but does not play a chime. These are known implementation boundaries, not hidden assumptions.
