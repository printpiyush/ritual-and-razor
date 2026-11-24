# 03 · Flows, Queue Rules & Test Checklist

## Customer flow — online join

1. Customer opens Home and checks whether online joining is open.
2. Customer opens Join Queue, enters a name and 10-digit phone number, selects one to three enabled services, and chooses Any or a named barber.
3. The summary displays the combined service price and duration plus an approximate wait.
4. Confirm creates a token and opens My Status.
5. The status view shows position and estimate. At position two it shows the “Start coming” message.
6. Reception calls the next eligible customer for an available barber.
7. The customer sees the called state and the assigned barber.
8. The barber starts the service, then marks it Done.

## Customer flow — walk-in

1. Reception opens Add walk-in.
2. Reception enters the customer's name, 10-digit phone number, one enabled service, and a barber preference.
3. The entry is appended to the same waiting list and receives the next token.
4. Reception uses the same Call next and queue-management workflow.

## Status model

| Current status | Allowed next status | Trigger |
|---|---|---|
| Waiting | Called | Reception selects the customer for an eligible barber |
| Waiting | Cancelled | Customer or reception confirms cancellation |
| Called | In chair | Assigned barber taps Start |
| Called | No-show | Reception marks no-show after the 10-minute grace period |
| In chair | Done | Assigned barber taps Done |

Terminal states are Done, Cancelled, and No-show. A terminal entry is not returned to the active waiting list. If a no-show arrives later, reception adds a new walk-in entry at the end.

## Assignment rules

- Queue order is first come, first served, based on `createdAt`.
- Call next is available only when the barber is on duty and currently Available.
- For barber X, select the earliest Waiting customer whose preference is X or Any.
- A customer who chose a named barber must not be silently assigned to a different barber.
- A barber can have only one assigned customer at a time.
- A barber with a current customer cannot be toggled onto a break.

## Validation and queue rules

- Online Join Queue requires a non-empty name, exactly 10 phone digits, at least one service, no more than three services, and an open queue.
- The Join Queue screen checks for an existing active spot for the same phone (`Waiting`, `Called`, or `In chair`) and opens that spot instead of creating another.
- The Reception walk-in form validates name and 10-digit phone but currently does not perform the same duplicate-phone check.
- A service must be enabled to appear in the online selection list and the walk-in service selector.
- Waiting entries over 60 minutes receive amber emphasis in Reception.
- A Called entry can be marked No-show after 10 minutes.
- Online joining is controlled by the Owner Settings open/closed switch. Reception walk-ins remain available while online joining is closed.

## Waiting-time estimate

The current estimate is an approximation:

1. Find the customers in Waiting status that are ahead of the target entry.
2. Sum the service minutes for those entries.
3. Divide by the number of on-duty barbers who are not on break and are eligible for the target's barber preference.
4. Round to the nearest whole minute and clamp the result to zero or above.
5. If there are no eligible working barbers, show an unavailable marker rather than dividing by zero.

This is a simple classroom estimate; it does not model exact chair schedules, service overlap, arrival uncertainty, or future barber availability.

## Shared-state behavior

- The app's source of truth is the singleton JSONB row `public.salon_state` with `id = 1`.
- UI state is cached in `localStorage`.
- `BroadcastChannel` and the browser `storage` event synchronize tabs in the same browser profile.
- Supabase Realtime propagates row updates to other connected devices when the Supabase environment and database policy are configured correctly.
- The local fallback does not provide cross-device synchronization by itself.

## Test checklist

Use synthetic customer data only.

### Customer experience
- [ ] Join with two services and confirm the displayed total price and duration.
- [ ] Try an empty name, an invalid phone, and no selected service; verify validation.
- [ ] Select three services, then try to select a fourth; verify the limit.
- [ ] Submit a phone number that already has an active online spot; verify the existing token opens.
- [ ] Join while online joining is closed; verify the disabled state and walk-in guidance.
- [ ] Check position two and confirm the “Start coming” message.
- [ ] Cancel a waiting spot and confirm it is removed from the active waiting order.

### Reception and barber operations
- [ ] Call next for Hitesh while the earliest waiting entry prefers Raj; verify it is skipped.
- [ ] Call next for a barber and verify an Any preference can be assigned.
- [ ] Verify Call next is unavailable for an off-duty, busy, or on-break barber.
- [ ] Verify No-show is disabled until the 10-minute grace period has elapsed.
- [ ] Mark a called entry No-show, then add the customer again; verify a new token at the end.
- [ ] Start and complete a service; verify In chair, Done, chair release, and served counter behavior.
- [ ] Toggle a barber break while the chair is empty; verify assignment eligibility updates.

### TV, owner, language, and sync
- [ ] Confirm the TV shows current assignments and up to five waiting tokens.
- [ ] Confirm a newly called token flashes gold on the TV.
- [ ] Disable a service in Owner Settings; verify it disappears from Join Queue.
- [ ] Toggle barber duty and verify the roster/assignment state updates.
- [ ] Close and reopen online joining; verify the Home and Join states.
- [ ] Switch English/Gujarati on the regular app shell and inspect important labels.
- [ ] Open separate browser contexts and test remote queue changes.
- [ ] Open the deployed site on a phone and desktop; make a test change and verify both update without refresh.

Refer to `docs/05-verification.md` for checks already confirmed during the project session and those still pending.
