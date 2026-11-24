# Prompt Log
## Ritual & Razor — Salon Queue Management System

> The prompts below are listed in the order of the project workflow. This file contains prompts only, as requested for the lab submission.

---

## 01 · Understand the assignment and plan the build

```text
I am building a Salon Queue Management System for my MSc IT vibe-coding lab. First read the TA handout and the project documents carefully. Understand all 7 required screens, the queue rules, the expected user roles, and the submission requirements. Before changing code, inspect the existing project and give me a clear implementation plan. Do not rewrite working parts of the project.
```

## 02 · Set up the application structure

```text
Set up the project using React, Vite and Tailwind CSS. Keep the code simple and component structure easy to understand. Create the application entry point, shared styling and navigation structure for all seven required screens: Home, Join Queue, My Status, Reception, Barber View, Waiting Area TV and Owner Settings. Make sure the project runs with npm run dev.
```

## 03 · Establish the Ritual & Razor visual identity

```text
Give the app a premium salon identity and use the name "Ritual & Razor" throughout the interface. Use a charcoal, warm gold, cream and near-black palette. Make the typography elegant but readable, use consistent spacing and rounded cards, and keep the design mobile-first. It should look like a real premium salon product, not a generic admin template. Keep buttons and labels clear and easy to tap.
```

## 04 · Build the Home screen and navigation

```text
Build the Home screen according to docs/02-screens.md. Show the salon branding, current queue information, barber availability and a prominent Join Queue action. Add navigation to the seven app views so I can open and test each screen during development. Keep the customer-facing experience clean on mobile and the staff navigation easy to find.
```

## 05 · Build Join Queue

```text
Build the Join Queue screen. Ask for the customer's name and 10-digit phone number, let the customer select one or more available services (maximum three), and choose a preferred barber or Any barber. Show the selected services, total price and estimated service duration before confirmation. Validate the phone number and required fields, and show clear feedback for invalid input. On confirmation, create a queue entry and open that customer's My Status page.
```

## 06 · Add token generation and My Status

```text
Implement token generation and the My Status screen. Every successful queue entry should receive a unique sequential token. Show the token, customer details, queue position and estimated waiting time. When the customer reaches second position, show a clear Start coming message. When Reception calls the customer, show a prominent It's your turn state with the assigned barber. Add a cancellation action with confirmation.
```

## 07 · Implement the queue rules in one place

```text
Implement the queue rules from docs/03-flows-rules.md consistently across the app. Use the statuses Waiting, Called, In chair, Done, Cancelled and No-show. Preserve first-come-first-served order. When Call next is used for a barber, select the earliest waiting customer who chose that barber or Any. Never assign a customer with a specific barber preference to a different barber. Do not allow a barber to have more than one active customer in the chair. Keep the rules centralized so the screens do not calculate different results.
```

## 08 · Build the Reception dashboard

```text
Build the Reception dashboard for tablet and desktop use. Show barber cards with their current customer and availability, plus the ordered waiting list with token, customer name, selected services and barber preference. Add controls to Call next, add a walk-in, cancel a queue entry and mark a called customer as No-show. Make the important actions easy to find and visually distinguish waiting, called and in-chair customers.
```

## 09 · Add the walk-in flow

```text
Add the receptionist walk-in flow. The receptionist should be able to enter a customer's name, phone number, services and barber preference without using the public Join Queue page. Validate the form and add the walk-in to the same queue at the end. Apply the same token, duplicate-phone and barber-preference rules used for online customers.
```

## 10 · Build Barber View

```text
Build the Barber View for an individual barber. Show the current assigned customer, token and selected services. Add Start and Done actions to move the customer through the service lifecycle. Also provide an Available / On break control. Make sure a break barber is not assigned a new customer and that changes are reflected in the other app screens.
```

## 11 · Build the Waiting Area TV screen

```text
Build the Waiting Area TV screen with large, high-contrast text that can be read from across the salon. Show each barber and the token currently being served, followed by the next waiting tokens. Highlight a newly called token with a clear gold visual treatment. Keep this screen uncluttered and suitable for a wide display.
```

## 12 · Build Owner Settings

```text
Build the Owner Settings screen. Allow the owner to open or close online queue joining, enable or disable individual services, and mark barbers as on duty or off duty. Show the salon's summary statistics. When online joining is closed, clearly explain that customers cannot join remotely while walk-ins can still be handled by Reception. Make the current open/closed state obvious.
```

## 13 · Add English and Gujarati language support

```text
Add an English / Gujarati language toggle and translate the main interface labels, buttons, messages and queue states. Switching language should update the visible screen without losing the current queue data or navigation state. Check that Gujarati text fits in the existing buttons and cards without clipping or overflow.
```

## 14 · Improve responsive layouts and interaction feedback

```text
Review all seven screens at mobile, tablet and desktop/TV sizes. Keep Join Queue and My Status optimized for phones, Reception comfortable on a tablet in landscape, and the TV display readable at 16:9. Fix overflowing text, awkward spacing and buttons that are too small. Add clear loading, empty, success and error states wherever an action may take time or there may be no queue entries.
```

## 15 · Fix the online queue closed-state issue

```text
I can't open the salon queue once it is closed. Check the Owner Settings open/close control and the logic that decides whether customers can join. Make sure I can reopen online joining after closing it. The closed state should disable only online joining; Reception must still be able to add walk-ins. Show the correct state and message on the Home and Join Queue screens.
```

## 16 · Check persistence and prepare shared state

```text
Review how the queue state is stored. It must not disappear on a normal page refresh, and all views should read the same queue state. Keep a sensible local fallback for development, but structure the state access so the app can use a hosted database for synchronization between separate devices. Avoid duplicating queue business rules in the storage layer.
```

## 17 · Connect Supabase database and Realtime

```text
Integrate Supabase so the queue is shared across different browsers and devices, not just within one browser's localStorage. Use the existing salon_state singleton row as the shared JSON state source of truth, and subscribe to Supabase Realtime changes so updates appear on other connected screens automatically. Preserve the current app behavior and local fallback if Supabase environment variables are not configured. Do not expose secret service-role keys in the frontend.
```

## 18 · Add Supabase setup and environment documentation

```text
Add a safe .env.example with placeholders for VITE_SUPABASE_URL and VITE_SUPABASE_PUBLISHABLE_KEY. Keep the real .env file out of Git and out of any shared project archive. Add the SQL setup needed for the salon_state table and Realtime publication, and document the Supabase dashboard steps required to configure the project. Clearly warn that broad anonymous demo access is not suitable for production customer data.
```

## 19 · Fix the Vite hot-reload issue

```text
The development log shows a Vite HMR error after the entry file is re-run. Inspect the React entry point and fix the issue with the smallest safe change. Prevent createRoot from being called more than once during hot-module replacement. Do not change the UI or queue behavior while fixing this development-only issue.
```

## 20 · Refine validation and edge cases

```text
Review the form and queue edge cases against docs/03-flows-rules.md. Make sure the maximum-three selection rule counts service cards only and does not accidentally count the barber preference. Prevent duplicate active queue entries for the same phone number. Check the closed-queue message, cancellation confirmation, no-show handling and re-adding a no-show customer at the end with a new token. Keep the changes focused.
```

## 21 · Check staff access and screen behavior

```text
Review the staff access flow for Reception, Barber View and Owner Settings. Make sure the PIN prompt behaves consistently and the test PIN is documented for the demo. Check the main controls on each staff screen and make sure the visible status updates match the shared queue state. Do not add a fake production authentication system; this is a classroom prototype.
```

## 22 · Prepare the Vercel deployment

```text
Prepare the React + Vite app for deployment on Vercel. Check the production build command, output directory, SPA route fallback and required environment variables. Remove any accidental localhost-only assumptions from the production path. Keep the existing Supabase connection and do not include .env or private credentials in the repository. Update the README with the live deployment URL and setup instructions.
```

## 23 · Verify cross-device synchronization

```text
Test the deployed app in separate browser contexts. Add a test customer in one browser and verify that the customer appears in another browser without refreshing. Then make a queue change from a mobile browser and confirm that the desktop view receives the update. Check the browser console for Supabase connection errors. Use dummy customer details only.
```

## 24 · Run the final assignment checklist

```text
Compare the current project with the TA handout and every file in docs/. Review all seven screens and the main customer, receptionist and barber flows. Check queue order, barber preference, Call next, Start/Done, cancellation, No-show, queue open/close, language toggle and responsive layouts. Run npm run build. Report only the checks that were actually tested, separate confirmed results from anything still requiring manual verification, and do not redesign working screens unnecessarily.
```

## 25 · Final documentation and submission cleanup

```text
Do a final documentation pass. Make sure README.md starts with the live demo link and includes the stack, setup steps, environment variables and test staff PIN. Ensure AGENTS.md points to the project brief, screen specification and queue rules. Keep prompts.md as a prompt-only chronological log, make reflection.md consistent with the actual project, and check that no .env file, node_modules, dist folder or temporary development files are included in the submission ZIP.
```
