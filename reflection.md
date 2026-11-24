# Reflection

**One thing the agent got wrong:** the waiting-time estimate.

When I first tested My Status, the customer at position 1 (`/status/S-14`) was told the wait was about **108 minutes**. That was obviously wrong — nobody was ahead of them. The agent had written the estimate as “sum the service minutes of every waiting customer, then divide by every barber on duty”. That breaks the rule in `docs/03-flows-rules.md`: only the customers *ahead* of this person count, and only the barbers who are working *and* eligible for that customer’s preference count.

**How I noticed:** I did not trust the number on screen. I opened the same token in the browser, compared the position (“1st”) with the estimate, and then read the `estimate()` function against the rule in my own rules doc. The mismatch was clear: position 1 cannot have a 108-minute wait when the queue is short. The same bug made every row on Reception and the TV show roughly the same wait (~123 min), so the error was visible on three screens at once.

**How I fixed it:** I did not ask for a rewrite. I pointed the agent at the exact rule and the exact symptom:

> The estimated wait shows 108 min for a customer who is 1st in line. Compare `estimate()` with the waiting-time rule in `docs/03-flows-rules.md` — it should count only customers ahead and divide by working, eligible barbers. Fix that and show me the new numbers for S-14, S-15 and a customer whose barber is on break.

The fix changed one shared function, so Join, My Status, Reception and the TV all corrected together: position 1 now shows `~0 min`, the next customer shows `~23 min`, and a customer whose chosen barber is on break sees “This barber is unavailable right now” instead of a made-up number. This also confirmed why the rules doc insists that queue logic lives in one place — fixing it once fixed every screen.

**What I would do differently:** write the waiting-time rule with a worked example in `docs/03` before building, and test position 1 and an on-break barber first. A concrete example (“position 1 with 2 barbers free ≈ 0 min”) would have caught this in the first prompt instead of the audit.
