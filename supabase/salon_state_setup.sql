-- Ritual & Razor — shared application state (classroom/demo setup).
-- The React client stores its existing state object in one JSONB row.

CREATE TABLE IF NOT EXISTS public.salon_state (
  id INTEGER PRIMARY KEY CHECK (id = 1),
  state JSONB NOT NULL,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

ALTER TABLE public.salon_state ENABLE ROW LEVEL SECURITY;

-- DEMO ONLY: the anonymous browser client needs access for the public lab demo.
-- This policy exposes the full JSON state (including test phone fields) to anon.
-- Do not use real customer data with this policy. Replace it with authenticated,
-- restrictive policies before any real-world deployment.
DROP POLICY IF EXISTS "salon_state_demo_public_access" ON public.salon_state;

CREATE POLICY "salon_state_demo_public_access"
ON public.salon_state
FOR ALL
TO anon
USING (true)
WITH CHECK (true);

-- Add the table to Supabase Realtime only if it is not already published.
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime'
      AND schemaname = 'public'
      AND tablename = 'salon_state'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.salon_state;
  END IF;
END
$$;
