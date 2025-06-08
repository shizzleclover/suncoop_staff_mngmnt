-- ========================================
-- SIMPLE ADMIN USER CREATION SCRIPT
-- ========================================
-- This is a simpler approach that works reliably with Supabase
-- Run this in your Supabase SQL Editor

-- ========================================
-- Method 1: Direct user creation (if you have service role access)
-- ========================================

-- First, temporarily disable RLS to insert the user
ALTER TABLE users DISABLE ROW LEVEL SECURITY;

-- Insert the admin user directly into the users table
-- Note: You'll need to create the auth user separately via Supabase Dashboard or API
INSERT INTO users (
    id,
    email,
    full_name,
    role,
    phone,
    is_active,
    created_at,
    updated_at
) VALUES (
    gen_random_uuid(),
    'admin@gmail.com',
    'System Administrator',
    'admin',
    '+1 (555) 000-0000',
    true,
    NOW(),
    NOW()
) ON CONFLICT (email) DO UPDATE SET
    role = 'admin',
    full_name = 'System Administrator',
    is_active = true,
    updated_at = NOW();

-- Re-enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- ========================================
-- Create sample shifts for testing
-- ========================================

INSERT INTO shifts (
    title,
    description,
    start_time,
    end_time,
    location,
    max_staff,
    hourly_rate,
    created_by,
    is_active
) VALUES (
    'Morning Reception Shift',
    'Handle front desk duties and customer inquiries',
    (CURRENT_DATE + INTERVAL '1 day' + TIME '09:00:00'),
    (CURRENT_DATE + INTERVAL '1 day' + TIME '17:00:00'),
    'Main Office - Front Desk',
    2,
    15.50,
    (SELECT id FROM users WHERE email = 'admin@gmail.com' LIMIT 1),
    true
),
(
    'Evening Cleaning Shift',
    'Clean office spaces and common areas',
    (CURRENT_DATE + INTERVAL '1 day' + TIME '18:00:00'),
    (CURRENT_DATE + INTERVAL '1 day' + TIME '22:00:00'),
    'Main Office - All Floors',
    3,
    18.00,
    (SELECT id FROM users WHERE email = 'admin@gmail.com' LIMIT 1),
    true
),
(
    'Weekend Security Patrol',
    'Security rounds and building monitoring',
    (CURRENT_DATE + INTERVAL '2 days' + TIME '22:00:00'),
    (CURRENT_DATE + INTERVAL '3 days' + TIME '06:00:00'),
    'Building Perimeter',
    2,
    20.00,
    (SELECT id FROM users WHERE email = 'admin@gmail.com' LIMIT 1),
    true
) ON CONFLICT DO NOTHING;

-- ========================================
-- Verify the admin user
-- ========================================

SELECT 
    id,
    email,
    full_name,
    role,
    is_active,
    created_at
FROM users 
WHERE email = 'admin@gmail.com';

-- ========================================
-- Display instructions
-- ========================================

DO $$
BEGIN
    RAISE NOTICE '========================================';
    RAISE NOTICE 'ADMIN USER SETUP INSTRUCTIONS';
    RAISE NOTICE '========================================';
    RAISE NOTICE '';
    RAISE NOTICE '1. The user profile has been created in the database';
    RAISE NOTICE '2. Now you need to create the auth user in Supabase:';
    RAISE NOTICE '';
    RAISE NOTICE 'Option A - Via Supabase Dashboard:';
    RAISE NOTICE '  - Go to Authentication > Users in your Supabase dashboard';
    RAISE NOTICE '  - Click "Add user"';
    RAISE NOTICE '  - Email: admin@gmail.com';
    RAISE NOTICE '  - Password: admin123';
    RAISE NOTICE '  - Check "Auto Confirm User"';
    RAISE NOTICE '';
    RAISE NOTICE 'Option B - Via API (using your service role key):';
    RAISE NOTICE '  curl -X POST https://your-project.supabase.co/auth/v1/admin/users \';
    RAISE NOTICE '    -H "Authorization: Bearer YOUR_SERVICE_ROLE_KEY" \';
    RAISE NOTICE '    -H "Content-Type: application/json" \';
    RAISE NOTICE '    -d ''{"email":"admin@gmail.com","password":"admin123","email_confirm":true}''';
    RAISE NOTICE '';
    RAISE NOTICE '3. After creating the auth user, you can log in with:';
    RAISE NOTICE '   Email: admin@gmail.com';
    RAISE NOTICE '   Password: admin123';
    RAISE NOTICE '';
    RAISE NOTICE 'Sample shifts have also been created for testing.';
    RAISE NOTICE '========================================';
END $$; 