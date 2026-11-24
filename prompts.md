# Prompts used

Every prompt for this project, in order. The prompts from this session are recorded verbatim. Add the prompts from the first ~70% of the build (Steps 1–7 of the guide) in the marked section below — including the ones that did not work.

## Session 1 — audit

**Prompt:**

> I am switching to you mid-way to finish a coding assignment before my deadline. About 70% of the codebase is already built, and I have attached the official assignment PDF along with the current project files.
>
> Please follow these steps strictly:
>
> 1. **Audit First (Do NOT write code yet):** Read the attached assignment PDF carefully and compare every requirement against the existing codebase. Output two clear lists: (a) Missing Parts, (b) Bugs & Issues.
> 2. **Wait for My Confirmation:** After listing the missing parts and bugs, stop and ask me which ones to fix first before making changes.
> 3. **Constraints:** Keep the existing working structure intact—do not rewrite the whole project from scratch. Stick strictly to the libraries, naming conventions, and rules specified in the PDF.
>
> Attached file: `C:\Users\piyus\Desktop\Salon_Queue_Management_Vibe_Coding_Guide.pdf`

**Reply to the audit:** “P0 blockers + core status (Recommended)”

## Session 2 — P0 fixes

**Prompt:**

> Fix the P0 blockers and core status bugs: Status token/states, wait estimate, duplicate join, staff PIN decision, README, prompts.md, Vercel config, and Git setup.

**Follow-up (dev log error):**

> The dev log shows a Vite HMR-only error from re-running the entry file. I'll fix that with a small root guard so editing `main.jsx` no longer calls `createRoot` twice.

## Session 3 — closed queue confusion

**Prompt (with screenshot of `/admin`):**

> i cant open the salon queue once it is closed???

**Fix:** the Admin “Online joining” card now has an explicit **Open online joining / Close online joining** button plus a walk-ins note.

## Session 4 — final verification before submission

**Prompt:**

> The project is deployed at https://ritual-and-razor.vercel.app.
>
> Perform a final verification before submission.
>
> 1. Check whether the latest commit `32d8aa1` is deployed.
> 2. Test all 7 required screens and their main functionality.
> 3. Verify queue rules: Call Next, barber preferences, Start/Done, No-show, cancellation and waiting-time calculations.
> 4. Test Admin PIN, closing and reopening online joining.
> 5. Check mobile responsiveness and cross-device synchronization.
> 6. Compare everything against the assignment requirements in `docs/` and the provided TA guide.
> 7. Fix any important bugs without redesigning or breaking existing features.
> 8. Update README.md with the live URL and check prompts.md.
>
> Run `npm run build` after changes.
>
> Give me a concise PASS/FAIL report and list anything still missing for submission.
>
> Do not claim something works unless you have tested it. Do not make unnecessary changes.

**Follow-ups from the verification run (test corrections, not product changes):**

> The max-3 check counted the selected barber-preference button as a service; count only service cards.
>
> The Admin check was case-sensitive against CSS-uppercased text; compare case-insensitively.
>
> The PDF only requires the services list to show minutes and price, not to edit them; adjust the check.

## Earlier build prompts (add before submitting)

> Paste the prompts from the first ~70% of the build here, in order — Step 1 (setup) through Step 7 (rules/polish). Include prompts that produced wrong results and what you changed afterwards. The TA guide asks for every prompt, including the ones that didn't work.
