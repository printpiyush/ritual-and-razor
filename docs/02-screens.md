# Salon Screens and Features

The app has exactly seven required screens. Use charcoal `#1F2937`, gold `#D4A017`, rounded cards, and clear states throughout. All visible labels, buttons, alerts, and empty states must switch between English and Gujarati from a shared language file. The barber roster is **Raj**, **Kishan**, and **Hitesh**.

## Screen 1: Home (`/`)

**Who and why:** Customers discover the salon, see whether the queue is open, and start joining.

**Top to bottom**

- Salon name and logo area.
- Status badge such as `Open - Closes 9 PM` or the closed state.
- Live summary card: people waiting and approximate total wait.
- Barber chips with name and status: `Raj`, `Kishan`, `Hitesh`; each can show Busy, Free, or On break.
- Large gold **Join Queue** button.
- English/Gujarati language toggle.

**Buttons and behavior**

- **Join Queue** opens `/join` when online joining is open.
- When online joining is closed, the button is disabled and explains that walk-ins are still allowed.
- Barber chips are informational and reflect current status.
- The language toggle updates every label on the screen.

**Responsive behavior and states**

- Mobile-first single-column layout with a prominent thumb-friendly CTA.
- Tablet expands the live summary and barber cards without changing the order of information.
- Empty queue says, in the selected language, that no one is waiting and customers can walk right in.
- Loading and unavailable-salon states are friendly and do not expose technical errors.

## Screen 2: Join Queue (`/join`)

**Who and why:** A customer provides contact details, chooses services and a barber preference, reviews the estimate, and joins once.

**Top to bottom**

- Name field.
- Phone field with exactly 10-digit validation.
- Service cards with multi-select, maximum three services. Include realistic examples such as Haircut (30 min, Rs 150), Beard trim (15 min, Rs 80), and Hair spa (45 min, Rs 400); services carry English and Gujarati names, minutes, price, and on/off state.
- Barber picker: `Any barber (fastest)`, `Raj`, `Kishan`, or `Hitesh`.
- Live summary: total service minutes, total price, and expected wait.
- Gold **Confirm** button.
- English/Gujarati language toggle.

**Buttons and behavior**

- Service cards toggle selection and immediately recalculate total time, price, and expected wait.
- The third selected service is allowed; a fourth selection is blocked with a clear message.
- **Confirm** validates name, phone, at least one service, and queue-open state. A valid submission creates a token and opens `/status/:id`.
- If the phone already has an active spot, show the existing spot instead of creating a duplicate.
- A disabled or unavailable service cannot be selected.

**Responsive behavior and states**

- Single-column cards and full-width controls on phones; tablet can use a two-column service grid.
- Preserve a sticky or visible summary on small screens so the total remains easy to review.
- Show inline validation errors, closed-queue messaging, and a recoverable synchronization error.

## Screen 3: My Status (`/status/:id`)

**Who and why:** A customer monitors one active queue spot and knows when to travel to the salon.

**Top to bottom**

- Large token, for example `S-14`.
- Position, for example `4th in line`.
- Circular countdown or prominent estimate such as `about 35 min`, updated automatically.
- Selected services and preferred barber.
- Contextual banner at second position: `Start coming to the salon`.
- Full-screen gold called state: `It's your turn! Go to Raj`, `Go to Kishan`, or `Go to Hitesh`.
- **Cancel my spot** button.
- English/Gujarati language toggle.

**Buttons and behavior**

- **Cancel my spot** opens a confirmation dialog; confirming moves the spot to Cancelled and removes it from active waiting order.
- Called state is visually emphatic, may pulse gently, and may use phone vibration where supported.
- Status and wait update automatically without manual refresh.

**Responsive behavior and states**

- Token and called state are legible on a phone at a glance; tablet may add explanatory detail.
- Handle missing or expired tokens with a clear recovery message.
- Show a completed, cancelled, or no-show state without offering invalid actions.

## Screen 4: Reception Dashboard (`/reception`) - tablet

**Who and why:** Reception manages the live queue and assigns the next eligible customer to a barber.

**Top to bottom and left to right**

- Header with queue open/closed indicator, current time, language toggle, and **+ Add walk-in**.
- Barber cards for Raj, Kishan, and Hitesh: current customer, time left, barber status, and **Call next**.
- Ordered waiting list: token, name, services, preferred barber, waiting time, **No-show**, and **Cancel** actions.
- Waiting longer than 60 minutes is highlighted in amber.

**Buttons and behavior**

- **+ Add walk-in** opens a quick form for name, phone, services, and preferred barber; valid walk-ins join at the end of the same queue.
- **Call next** selects the earliest eligible customer according to `docs/03-flows-rules.md`, changes them to Called, and updates the customer view and TV.
- **No-show** is available for a Called customer after the 10-minute grace period and removes them from active service order.
- **Cancel** confirms before moving a waiting customer to Cancelled.
- Barber status can be reflected here but barber work actions happen in Barber View.

**Responsive behavior and states**

- Optimized for a 10-inch tablet in landscape: barber cards stay easy to scan and the waiting list remains ordered.
- On narrower windows, stack barber cards above the list without hiding actions.
- Empty queue says no one is waiting; an unavailable or on-break barber explains why Call next may skip them.

## Screen 5: Barber View (`/barber/:name`) - phone

**Who and why:** Raj, Kishan, or Hitesh manages the customer currently in their chair and signals availability.

**Top to bottom**

- Barber name and current availability status.
- Current customer card with name, services, and timer since start.
- Large **Start** button before service begins; after starting, show **Done**.
- `Next for you` preview with token, customer name, and service.
- **On break / Available** toggle.
- English/Gujarati language toggle.

**Buttons and behavior**

- **Start** moves the called customer to In chair and starts the timer.
- **Done** moves the customer to Done and frees the barber for the next eligible customer.
- **On break / Available** changes barber eligibility and communicates the state to customers and reception.
- Work actions update Reception, TV, and the customer's status automatically.

**Responsive behavior and states**

- Phone-first, one-handed layout with tap targets at least 44px.
- Empty chair state says no current customer; on-break state clearly explains that new assignments pause.
- Prevent Start or Done when the current status does not permit that action.

## Screen 6: Waiting Area TV (`/display`)

**Who and why:** Customers in the salon see who is being served and which tokens are next.

**Layout**

- Full-screen, high-contrast charcoal display.
- One row or card per barber with name, photo/avatar, and `Now: S-12` or an empty-chair state for Raj, Kishan, and Hitesh.
- `Up next` list of five tokens with estimated times.
- Newly called token flashes gold and plays a short chime where supported.

**Buttons and behavior**

- This is a display screen rather than a staff-control surface; it has no queue-mutating buttons.
- New calls, starts, completions, cancellations, and no-shows update automatically.

**Responsive behavior and states**

- Designed for TV readability from approximately five metres; large type and strong contrast take priority over density.
- Adapt to common 16:9 screens and remain legible on a tablet preview.
- Empty barber and empty queue states are explicit; do not show stale tokens.

## Screen 7: Owner Settings (`/admin`)

**Who and why:** The owner controls today's services, barber roster, online joining, and summary metrics.

**Top to bottom**

- Services list with name in English and Gujarati, duration in minutes, price, and on/off control.
- Barbers on duty today with toggles for Raj, Kishan, and Hitesh.
- Queue switch: Open / Closed for online joining.
- Today's stats: customers served, average wait, and no-shows.
- English/Gujarati language toggle.

**Buttons and behavior**

- Service on/off changes what can be selected on Join Queue; duration and price are reflected in the live summary.
- Barber duty toggles affect eligible assignment and visible availability.
- Closing online joining disables remote joining with a clear message while still allowing receptionist walk-ins.
- Stats reflect the current day's queue activity.

**Responsive behavior and states**

- Use readable stacked settings sections on mobile and a denser two-column layout on tablet/desktop.
- Confirm destructive or scope-changing actions where appropriate and show save/error feedback.
- Empty stats use zero values with explanatory labels rather than blank cards.
