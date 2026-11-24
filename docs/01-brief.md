# Salon Queue Project Brief

## Problem

Customers can spend one to two hours waiting at a busy salon without knowing when their turn will arrive. Unclear order and barber availability cause avoidable frustration, early departures, and arguments about who came first.

This app gives customers a live place in line and gives salon staff one shared view of the queue, barber work, and waiting-area announcements.

## Users

- **Customer:** joins remotely or through a walk-in, chooses services and a preferred barber, and follows live status.
- **Receptionist or owner:** adds walk-ins, manages the waiting list, calls the next customer, handles cancellations and no-shows, and controls whether online joining is open.
- **Barber:** sees the current customer, starts and completes the service, and marks availability or break status.
- **Waiting-area audience:** reads the TV display for current and upcoming tokens.

## Must-have features

1. Customers can join from a phone by selecting one or more services and either **Any barber**, **Raj**, **Kishan**, or **Hitesh**.
2. The customer receives a token, live queue position, estimated wait, and a **Start coming to the salon** message when they are second in line.
3. A receptionist dashboard supports walk-ins, ordered waiting-list management, **Call next**, **No-show**, and **Cancel**.
4. Each barber has a view for the current customer, service timer, **Start**, **Done**, and **On break / Available**.
5. A waiting-area TV shows each barber's current token and the next five tokens, with a gold alert when a customer is called.
6. Owner settings manage services, service duration and price, which barbers are on duty, online queue open/closed state, and today's stats.
7. All screens support English and Gujarati labels through a language toggle.
8. Phone, tablet, and TV windows stay synchronized without a manual refresh.

## Don't build

- Online payment.
- Future-date appointments.
- SMS or WhatsApp messaging.
- Loyalty or rewards features.
- Multiple salon branches.

## Look and feel

Premium salon feel: dark charcoal `#1F2937` with gold `#D4A017` accents, clean rounded cards, mobile-first layouts, clear tap targets, and readable TV typography. Visible labels must be available in English and Gujarati.

## Scope boundary

This planning set defines the UI, behavior, and queue rules. Implementation follows the build plan in the assignment guide and must not add features outside this brief.
