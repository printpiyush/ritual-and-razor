-- Ritual & Razor: shared application-state table for the existing React app.
-- This preserves the current frontend state shape and enables cross-device Realtime sync.

CREATE TABLE IF NOT EXISTS public.salon_state (
  id INTEGER PRIMARY KEY CHECK (id = 1),
  state JSONB NOT NULL,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

ALTER TABLE public.salon_state ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "salon_state_demo_public_access" ON public.salon_state;
CREATE POLICY "salon_state_demo_public_access"
ON public.salon_state
FOR ALL
TO anon
USING (true)
WITH CHECK (true);

-- Allow Supabase Realtime to publish changes to the singleton state row.
ALTER PUBLICATION supabase_realtime ADD TABLE public.salon_state;
