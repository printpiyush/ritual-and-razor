# 02 · Screens & Features
## Route-level product specification

The interface contains seven primary views. The shared shell provides the salon wordmark, navigation, and English/Gujarati toggle on the regular app routes. The TV route is a standalone display view.

### Screen 1 — Home
**Route:** `/`  
**Primary user:** Customer

**Purpose:** Introduce the salon, show the queue pulse, and provide the entry point for online joining.

**Visible content**
- Ritual & Razor identity and queue status.
- Live count of customers currently waiting.
- Approximate wait estimate.
- Barber cards for Raj, Kishan, and Hitesh with current availability state.
- Primary Join Queue action.

**Interactions**
- Join Queue navigates to `/join` while online joining is open.
- When online joining is closed, the action is disabled and the customer is directed to reception for a walk-in.
- Barber cards are informational.

**Responsive intent**
- One-column content and a prominent CTA on phones.
- Expanded summary and barber cards on wider screens.
- Empty queue copy should remain reassuring and visible.

### Screen 2 — Join Queue
**Route:** `/join`  
**Primary user:** Customer

**Purpose:** Collect the information needed to create a queue entry.

**Visible content**
- Customer name and phone number.
- Enabled service cards, each showing English/Gujarati name, duration, and price.
- Barber preference: Any barber, Raj, Kishan, or Hitesh.
- Live summary of selected-service price, duration, and estimated wait.
- Confirm action.

**Interactions**
- Phone input accepts digits and is limited to 10 characters; submission validates exactly 10 digits.
- At least one service is required; up to three may be selected.
- Service selection recalculates price and service duration.
- A repeat submission for a phone with an existing active online spot opens that spot instead of adding another.
- Successful submission issues the next token and navigates to `/status/:token`.
- Online joining is blocked when the queue is closed.

**Responsive intent**
- Full-width fields and service cards on phones.
- Two-column service grid on larger screens.
- Keep the live total visible while selecting services.

### Screen 3 — My Status
**Route:** `/status/:token`  
**Primary user:** Customer

**Purpose:** Show one customer's progress through the queue.

**Visible content**
- Large token and ordinal position.
- Approximate wait estimate.
- Selected services and preferred barber.
- “Start coming to the salon” message at second position.
- Called, in-chair, done, cancelled, no-show, and missing-token states.

**Interactions**
- Cancel my spot opens a confirmation step; confirmation moves the entry to Cancelled.
- Called state identifies the assigned barber.
- Status updates arrive through the shared state mechanism; no manual refresh is required during normal connected use.

**Responsive intent**
- Token, position, estimate, and called state should be immediately readable on a phone.
- Terminal states provide a clear next step or return-to-home action.

### Screen 4 — Reception
**Route:** `/reception`  
**Primary user:** Receptionist / owner  
**Preferred device:** Tablet or desktop

**Purpose:** Operate the queue and assign customers to eligible barbers.

**Visible content**
- Queue open/closed status and local clock.
- Add walk-in form.
- Barber cards showing barber name, availability, current customer, and time remaining.
- Ordered waiting list with token, customer, services, preferred barber, elapsed wait, and estimated wait.
- Amber emphasis for customers who have waited over 60 minutes.

**Interactions**
- Add walk-in validates name and a 10-digit phone number, then appends the entry to the queue.
- Call next is enabled only for an on-duty barber whose state is Available. It chooses the earliest waiting entry matching that barber or Any.
- A called customer becomes eligible for No-show after the 10-minute grace period.
- Reception can cancel a waiting entry after a confirmation step.
- No-show releases the barber assignment and increments the no-show counter.

**Responsive intent**
- Barber cards should be easy to scan above the queue table.
- The waiting list may scroll horizontally on narrow screens rather than hiding operational columns.

### Screen 5 — Barber View
**Route:** `/barber/:name`  
**Primary user:** Barber  
**Preferred device:** Phone

**Purpose:** Let a barber progress the customer assigned to their chair.

**Visible content**
- Barber name and availability control.
- Current customer, token, selected services, and elapsed service timer.
- Start or Done action, depending on the current status.
- Next eligible customer preview.

**Interactions**
- Start moves the assigned customer from Called to In chair and starts the timer.
- Done moves the customer to Done, clears the chair, marks the barber Available, and increments the served counter.
- Break/Available can be toggled only when the barber has no current customer.
- Updates are reflected in other connected views through shared state.

**Responsive intent**
- One-handed layout with large controls and tap targets of at least 44px.
- Empty-chair and on-break states remain explicit.

### Screen 6 — Waiting Area TV
**Route:** `/display`  
**Primary user:** Waiting-area visitors  
**Preferred device:** 16:9 TV

**Purpose:** Make barber assignments and the upcoming queue visible from a distance.

**Visible content**
- Dark, high-contrast display.
- One card per barber with initials, name, and current token or availability.
- Up to five upcoming waiting tokens with approximate estimates.
- A gold pulse on the currently called token.

**Interactions**
- Display-only view; it has no queue-mutating controls.
- Changes appear when the shared state updates.
- The current implementation uses a visual gold flash; audio chime is not implemented.
- This route does not currently show its own language toggle.

**Responsive intent**
- Large typography, generous spacing, and a 16:9-friendly composition take priority over dense controls.

### Screen 7 — Owner Settings
**Route:** `/admin`  
**Primary user:** Salon owner

**Purpose:** Manage the daily operating switches used by the prototype.

**Visible content**
- Service list with English/Gujarati name, minutes, price, and Enabled/Disabled control.
- Barber duty toggles for Raj, Kishan, and Hitesh.
- Online joining state and Open/Close action.
- Served count, average wait, and no-show metrics.

**Interactions**
- Service toggle controls whether it appears in Join Queue.
- Barber duty toggle affects assignment eligibility.
- Open/Close changes online joining; walk-ins remain available at reception.
- Served and no-show counts update with the corresponding queue actions.
- Average wait is currently a seeded demo value; it is not recalculated from completed services.
- Service price and duration are displayed but are not editable in this screen.

**Responsive intent**
- Stack settings groups on phones.
- Use a two-column settings and metrics layout on wider screens.

### Access and navigation

- The regular app header links Home, Join Queue, Reception, Barber, Waiting Area TV, and Admin.
- Reception, Barber, and Admin show a demo PIN gate (`2468`). This is client-side demonstration access, not production authentication.
- My Status is reached after joining or by opening a token route.
