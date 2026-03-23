-- =============================================================
-- Lakeside Health — Contact Submissions Table
-- Run this in: Supabase Dashboard → SQL Editor → New Query
-- This does NOT modify any existing tables.
-- =============================================================

-- 1. Create the table
CREATE TABLE IF NOT EXISTS public.contact_submissions (
    id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name        TEXT NOT NULL,
    company     TEXT NOT NULL,
    email       TEXT NOT NULL,
    phone       TEXT,
    company_size TEXT,
    interest    TEXT,
    message     TEXT,
    source_page TEXT DEFAULT 'website',
    status      TEXT DEFAULT 'new',
    created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Add a comment for documentation
COMMENT ON TABLE public.contact_submissions IS 'Stores contact form submissions from the Lakeside Health website. Status: new → contacted → closed.';

-- 3. Enable Row Level Security
ALTER TABLE public.contact_submissions ENABLE ROW LEVEL SECURITY;

-- 4. Allow anonymous INSERT (website visitors can submit the form)
CREATE POLICY "Allow anonymous inserts"
    ON public.contact_submissions
    FOR INSERT
    TO anon
    WITH CHECK (true);

-- 5. Allow authenticated users (admin) to read all rows
CREATE POLICY "Allow authenticated read"
    ON public.contact_submissions
    FOR SELECT
    TO authenticated
    USING (true);

-- 6. Allow authenticated users (admin) to update status
CREATE POLICY "Allow authenticated update"
    ON public.contact_submissions
    FOR UPDATE
    TO authenticated
    USING (true)
    WITH CHECK (true);
