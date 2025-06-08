-- ========================================
-- CREATE TEST ADMIN USER
-- ========================================
-- This script creates a test admin user for the SunCoopAtt system
-- Email: admin@gmail.com
-- Password: admin123
-- Role: admin

-- Note: This script should be run in the Supabase SQL Editor
-- Make sure to run this AFTER the main schema has been applied

-- ========================================
-- Step 1: Create the auth user
-- ========================================
-- This creates the user in Supabase Auth
-- The trigger will automatically create the profile in the users table

INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    invited_at,
    confirmation_token,
    confirmation_sent_at,
    recovery_token,
    recovery_sent_at,
    email_change_token_new,
    email_change,
    email_change_sent_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin,
    created_at,
    updated_at,
    phone,
    phone_confirmed_at,
    phone_change,
    phone_change_token,
    phone_change_sent_at,
    email_change_token_current,
    email_change_confirm_status,
    banned_until,
    reauthentication_token,
    reauthentication_sent_at
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    gen_random_uuid(),
    'authenticated',
    'authenticated',
    'admin@gmail.com',
    crypt('admin123', gen_salt('bf')),
    NOW(),
    NOW(),
    '',
    NOW(),
    '',
    NULL,
    '',
    '',
    NULL,
    NULL,
    '{"provider": "email", "providers": ["email"]}',
    '{"full_name": "System Administrator"}',
    FALSE,
    NOW(),
    NOW(),
    NULL,
    NULL,
    '',
    '',
    NULL,
    '',
    0,
    NULL,
    '',
    NULL
);

-- ========================================
-- Step 2: Update the user profile to admin role
-- ========================================
-- The trigger creates a basic profile, but we need to update it to admin role

UPDATE users 
SET 
    role = 'admin',
    full_name = 'System Administrator',
    phone = '+1 (555) 000-0000',
    updated_at = NOW()
WHERE email = 'admin@gmail.com';

-- ========================================
-- Step 3: Verify the admin user was created
-- ========================================
-- This query will show the created admin user

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
-- Alternative Method (if the above doesn't work)
-- ========================================
-- If the direct auth.users insert doesn't work due to RLS or other restrictions,
-- you can use this alternative approach:

/*
-- Method 2: Use Supabase Auth API (run this in your app or via API)
-- This is the recommended approach for production

-- 1. First, create the user via Supabase Auth API:
POST https://your-project.supabase.co/auth/v1/admin/users
Headers:
  Authorization: Bearer YOUR_SERVICE_ROLE_KEY
  Content-Type: application/json

Body:
{
  "email": "admin@gmail.com",
  "password": "admin123",
  "email_confirm": true,
  "user_metadata": {
    "full_name": "System Administrator"
  }
}

-- 2. Then update the role in the users table:
UPDATE users 
SET role = 'admin' 
WHERE email = 'admin@gmail.com';
*/

-- ========================================
-- Step 4: Create some sample data for testing
-- ========================================

-- Insert a sample shift for testing
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
    (SELECT id FROM users WHERE email = 'admin@gmail.com'),
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
    (SELECT id FROM users WHERE email = 'admin@gmail.com'),
    true
);

-- ========================================
-- Step 5: Display success message
-- ========================================

DO $$
DECLARE
    admin_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO admin_count 
    FROM users 
    WHERE email = 'admin@gmail.com' AND role = 'admin';
    
    IF admin_count > 0 THEN
        RAISE NOTICE 'SUCCESS: Admin user created successfully!';
        RAISE NOTICE 'Email: admin@gmail.com';
        RAISE NOTICE 'Password: admin123';
        RAISE NOTICE 'Role: admin';
        RAISE NOTICE 'You can now log in to the SunCoopAtt app with these credentials.';
    ELSE
        RAISE NOTICE 'ERROR: Admin user creation failed. Please check the logs.';
    END IF;
END $$; 