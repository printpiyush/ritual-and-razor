# Project Reflection
## Ritual & Razor — Vibe Coding Lab

One issue the coding agent got wrong was the waiting-time estimate. During testing, a customer at position 1 (`/status/S-14`) was shown an estimate of about **108 minutes**, even though nobody was ahead of them. The agent had summed the service minutes for every waiting customer and divided that total by the number of barbers on duty. That did not match the rule in `docs/03-flows-rules.md`: the estimate should include only customers ahead of the selected token and only barbers eligible for that customer's barber preference.

I noticed the issue by comparing the displayed position with the estimate instead of accepting the number at face value. I then checked the shared `estimate()` function against the written rule. The same calculation was also affecting the wait shown on Reception and the TV, so the mismatch was visible in more than one place.

Rather than asking for a full rewrite, I gave the agent the exact symptom and pointed it to the single function and the rule it needed to follow:

> The estimated wait shows 108 min for a customer who is 1st in line. Compare `estimate()` with the waiting-time rule in `docs/03-flows-rules.md` — it should count only customers ahead and divide by working, eligible barbers. Fix that and show me the new numbers for S-14, S-15 and a customer whose barber is on break.

The correction was made in the shared estimate function. The recorded retest showed position 1 at approximately zero minutes, the next customer at approximately 23 minutes, and a customer whose chosen barber was on break receiving an unavailable state rather than a misleading number. Because the screens use the same calculation, correcting it once improved the estimate in Join Queue, My Status, Reception, and the TV.

The main lesson for me was to write business rules with a small worked example before asking an agent to implement them. I would also test position 1 and an on-break barber early. That would have exposed the error sooner and made the expected behavior much harder to misinterpret.
