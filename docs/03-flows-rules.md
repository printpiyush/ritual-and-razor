# Salon Flows and Queue Rules

## Flow: remote customer

1. Customer opens Home, sees the salon and queue status, and taps **Join Queue**.
2. Customer chooses services and `Any barber`, `Raj`, `Kishan`, or `Hitesh`, then confirms valid name and 10-digit phone details.
3. The app creates a token such as `S-14`, shows the position and estimated wait on My Status, and keeps it updated automatically.
4. When the customer reaches second in line, My Status shows `Start coming to the salon`.
5. Reception taps **Call next** on the eligible barber's card. The spot becomes Called, the customer's phone shows `It's your turn! Go to Raj`, `Go to Kishan`, or `Go to Hitesh`, and the TV flashes the token.
6. The barber taps **Start**, then **Done**. The spot becomes In chair, then Done, and disappears from active waiting order.

## Flow: walk-in

1. Reception taps **+ Add walk-in**.
2. Reception enters name, phone, services, and an optional barber preference.
3. The walk-in joins the same queue at the end, following first come, first served order.
4. The customer receives the same token and status behavior as a remote customer.

## Statuses and allowed moves

- `Waiting -> Called -> In chair -> Done`.
- `Waiting -> Cancelled`.
- `Called -> No-show`.
- Statuses never move backward.
- A customer may not be simultaneously active in two spots.

## Queue rules

- First come, first served.
- **Call next** for a barber selects the earliest waiting customer who chose that barber or chose `Any barber`.
- A customer who chose Raj is never assigned to Kishan or Hitesh; the same barber-preference rule applies independently to Kishan and Hitesh.
- A customer who chose `Any barber` may be assigned to the eligible barber who is calling next.
- A barber has only one customer in the chair at a time.
- Waiting time is approximately `total minutes of services ahead / barbers working`.
- Use the number of working, eligible barbers in the estimate; do not divide by zero when no barber is available.
- One active spot per phone number. A duplicate join shows the existing spot instead of creating another.
- A service selection may contain no more than three services.

## Waiting, cancellation, and no-show rules

- Waiting longer than 60 minutes is highlighted in amber on Reception.
- When a Called customer is not present after 10 minutes, reception can mark them No-show.
- If a no-show arrives later, reception adds them again at the end with a new token.
- A customer can cancel their own spot from My Status only after confirmation; the status becomes Cancelled.
- Reception can cancel a waiting spot after confirmation.
- Online joining closes 30 minutes before closing; walk-ins are still allowed.
- If Raj, Kishan, or Hitesh is on break, customers who specifically chose that barber see that the barber is on break; they are not silently reassigned.
- Closing online joining disables the Home/Join action with a clear message but does not close reception walk-ins.

## Synchronization rules

- Changes made in Join Queue, Reception, Barber View, Owner Settings, and Waiting Area TV propagate to all open views automatically.
- Customer called state, Start/Done changes, queue closure, and barber break state should appear across views within approximately five seconds.
- Do not require a manual refresh for normal queue operations.

## Test checklist

- [ ] Join with two services -> correct total time and price are shown.
- [ ] Same phone joins twice -> existing spot is shown and no duplicate is created.
- [ ] Call next for Hitesh skips a customer who chose Raj.
- [ ] Call next for Raj skips a customer who chose Kishan or Hitesh.
- [ ] Call next can select a customer who chose Any barber.
- [ ] Call next -> the customer's phone shows `It's your turn` within five seconds.
- [ ] Start and Done on Barber View update Reception and TV.
- [ ] No-show, then re-add -> the customer goes to the end with a new token.
- [ ] Close online queue -> Join button is disabled with a clear message while walk-ins remain possible.
- [ ] Language toggle switches all labels to Gujarati and back to English.
- [ ] Waiting time goes down as customers finish.
- [ ] Waiting longer than 60 minutes is highlighted in amber.
- [ ] A barber on break is shown as unavailable and does not receive an invalid assignment.
- [ ] Phone, tablet, and TV windows stay in sync without a manual refresh.
