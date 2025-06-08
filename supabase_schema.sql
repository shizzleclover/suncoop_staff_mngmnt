-- SunCoopAtt Database Schema
-- This file contains all table definitions, triggers, and security policies for Supabase

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ========================================
-- USERS TABLE
-- ========================================
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT UNIQUE NOT NULL,
    full_name TEXT NOT NULL,
    avatar_url TEXT,
    role TEXT NOT NULL DEFAULT 'staff' CHECK (role IN ('admin', 'staff')),
    phone TEXT,
    employee_id TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Create index for performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_is_active ON users(is_active);

-- ========================================
-- SHIFTS TABLE
-- ========================================
CREATE TABLE shifts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    description TEXT,
    start_time TIMESTAMP WITH TIME ZONE NOT NULL,
    end_time TIMESTAMP WITH TIME ZONE NOT NULL,
    location TEXT,
    max_staff INTEGER DEFAULT 1 CHECK (max_staff > 0),
    hourly_rate DECIMAL(10,2),
    created_by UUID REFERENCES users(id) ON DELETE SET NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    
    CONSTRAINT valid_shift_time CHECK (end_time > start_time)
);

-- Create indexes for performance
CREATE INDEX idx_shifts_start_time ON shifts(start_time);
CREATE INDEX idx_shifts_end_time ON shifts(end_time);
CREATE INDEX idx_shifts_created_by ON shifts(created_by);
CREATE INDEX idx_shifts_is_active ON shifts(is_active);

-- ========================================
-- SHIFT BOOKINGS TABLE
-- ========================================
CREATE TABLE shift_bookings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    shift_id UUID REFERENCES shifts(id) ON DELETE CASCADE NOT NULL,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE NOT NULL,
    status TEXT DEFAULT 'booked' CHECK (status IN ('booked', 'cancelled', 'confirmed', 'completed', 'rejected')),
    booked_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    cancelled_at TIMESTAMP WITH TIME ZONE,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    
    UNIQUE(shift_id, user_id)
);

-- Create indexes for performance
CREATE INDEX idx_shift_bookings_shift_id ON shift_bookings(shift_id);
CREATE INDEX idx_shift_bookings_user_id ON shift_bookings(user_id);
CREATE INDEX idx_shift_bookings_status ON shift_bookings(status);
CREATE INDEX idx_shift_bookings_booked_at ON shift_bookings(booked_at);

-- ========================================
-- CLOCK RECORDS TABLE
-- ========================================
CREATE TABLE clock_records (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE NOT NULL,
    shift_booking_id UUID REFERENCES shift_bookings(id) ON DELETE SET NULL,
    clock_in_time TIMESTAMP WITH TIME ZONE NOT NULL,
    clock_out_time TIMESTAMP WITH TIME ZONE,
    
    -- Security & Location Data
    clock_in_wifi_ssid TEXT,
    clock_in_wifi_bssid TEXT,
    clock_in_latitude DECIMAL(10, 8),
    clock_in_longitude DECIMAL(11, 8),
    clock_in_device_info JSONB,
    
    clock_out_wifi_ssid TEXT,
    clock_out_wifi_bssid TEXT,
    clock_out_latitude DECIMAL(10, 8),
    clock_out_longitude DECIMAL(11, 8),
    clock_out_device_info JSONB,
    
    -- Calculated fields
    total_hours DECIMAL(5, 2),
    break_time_minutes INTEGER DEFAULT 0,
    overtime_hours DECIMAL(5, 2) DEFAULT 0,
    
    -- Status and validation
    status TEXT DEFAULT 'clocked_in' CHECK (status IN ('clocked_in', 'clocked_out', 'invalid')),
    is_valid BOOLEAN DEFAULT true,
    validation_notes TEXT,
    
    -- Admin override
    admin_adjusted BOOLEAN DEFAULT false,
    admin_notes TEXT,
    adjusted_by UUID REFERENCES users(id) ON DELETE SET NULL,
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    
    CONSTRAINT valid_clock_times CHECK (clock_out_time IS NULL OR clock_out_time > clock_in_time)
);

-- Create indexes for performance
CREATE INDEX idx_clock_records_user_id ON clock_records(user_id);
CREATE INDEX idx_clock_records_clock_in_time ON clock_records(clock_in_time);
CREATE INDEX idx_clock_records_status ON clock_records(status);
CREATE INDEX idx_clock_records_shift_booking_id ON clock_records(shift_booking_id);

-- ========================================
-- APP SETTINGS TABLE (for system configuration)
-- ========================================
CREATE TABLE app_settings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    key TEXT UNIQUE NOT NULL,
    value JSONB NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Create index for performance
CREATE INDEX idx_app_settings_key ON app_settings(key);

-- ========================================
-- TRIGGERS FOR UPDATED_AT
-- ========================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = timezone('utc'::text, now());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply triggers to all tables
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_shifts_updated_at BEFORE UPDATE ON shifts FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_shift_bookings_updated_at BEFORE UPDATE ON shift_bookings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_clock_records_updated_at BEFORE UPDATE ON clock_records FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_app_settings_updated_at BEFORE UPDATE ON app_settings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ========================================
-- AUTOMATIC USER PROFILE CREATION
-- ========================================
CREATE OR REPLACE FUNCTION create_user_profile()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO users (id, email, full_name, role)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'full_name', 'Unknown'),
        COALESCE(NEW.raw_user_meta_data->>'role', 'staff')
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create user profile when auth user is created
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION create_user_profile();

-- ========================================
-- ROW LEVEL SECURITY (RLS)
-- ========================================

-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE shifts ENABLE ROW LEVEL SECURITY;
ALTER TABLE shift_bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE clock_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_settings ENABLE ROW LEVEL SECURITY;

-- ========================================
-- RLS POLICIES FOR USERS TABLE
-- ========================================

-- Users can view their own profile
CREATE POLICY "Users can view own profile" ON users
    FOR SELECT USING (auth.uid() = id);

-- Users can update their own profile
CREATE POLICY "Users can update own profile" ON users
    FOR UPDATE USING (auth.uid() = id);

-- Admins can view all users
CREATE POLICY "Admins can view all users" ON users
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Admins can insert new users
CREATE POLICY "Admins can insert users" ON users
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Admins can update all users
CREATE POLICY "Admins can update all users" ON users
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Admins can delete users
CREATE POLICY "Admins can delete users" ON users
    FOR DELETE USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- ========================================
-- RLS POLICIES FOR SHIFTS TABLE
-- ========================================

-- All authenticated users can view active shifts
CREATE POLICY "All users can view active shifts" ON shifts
    FOR SELECT USING (is_active = true);

-- Admins can view all shifts
CREATE POLICY "Admins can view all shifts" ON shifts
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Admins can create shifts
CREATE POLICY "Admins can create shifts" ON shifts
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Admins can update shifts
CREATE POLICY "Admins can update shifts" ON shifts
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Admins can delete shifts
CREATE POLICY "Admins can delete shifts" ON shifts
    FOR DELETE USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- ========================================
-- RLS POLICIES FOR SHIFT_BOOKINGS TABLE
-- ========================================

-- Users can view their own bookings
CREATE POLICY "Users can view own bookings" ON shift_bookings
    FOR SELECT USING (user_id = auth.uid());

-- Users can create their own bookings
CREATE POLICY "Users can create own bookings" ON shift_bookings
    FOR INSERT WITH CHECK (user_id = auth.uid());

-- Users can update their own bookings
CREATE POLICY "Users can update own bookings" ON shift_bookings
    FOR UPDATE USING (user_id = auth.uid());

-- Admins can view all bookings
CREATE POLICY "Admins can view all bookings" ON shift_bookings
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Admins can update all bookings
CREATE POLICY "Admins can update all bookings" ON shift_bookings
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Admins can delete bookings
CREATE POLICY "Admins can delete bookings" ON shift_bookings
    FOR DELETE USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- ========================================
-- RLS POLICIES FOR CLOCK_RECORDS TABLE
-- ========================================

-- Users can view their own clock records
CREATE POLICY "Users can view own clock records" ON clock_records
    FOR SELECT USING (user_id = auth.uid());

-- Users can create their own clock records
CREATE POLICY "Users can create own clock records" ON clock_records
    FOR INSERT WITH CHECK (user_id = auth.uid());

-- Users can update their own clock records (for clock out)
CREATE POLICY "Users can update own clock records" ON clock_records
    FOR UPDATE USING (user_id = auth.uid());

-- Admins can view all clock records
CREATE POLICY "Admins can view all clock records" ON clock_records
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Admins can update all clock records
CREATE POLICY "Admins can update all clock records" ON clock_records
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- ========================================
-- RLS POLICIES FOR APP_SETTINGS TABLE
-- ========================================

-- Only admins can access app settings
CREATE POLICY "Only admins can access app settings" ON app_settings
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- ========================================
-- FUNCTIONS FOR BUSINESS LOGIC
-- ========================================

-- Function to check if a shift has available spots
CREATE OR REPLACE FUNCTION shift_has_available_spots(shift_id_param UUID)
RETURNS BOOLEAN AS $$
DECLARE
    max_staff_count INTEGER;
    current_bookings INTEGER;
BEGIN
    -- Get max staff for the shift
    SELECT max_staff INTO max_staff_count
    FROM shifts
    WHERE id = shift_id_param AND is_active = true;
    
    -- If shift not found or inactive, return false
    IF max_staff_count IS NULL THEN
        RETURN false;
    END IF;
    
    -- Count current bookings
    SELECT COUNT(*) INTO current_bookings
    FROM shift_bookings
    WHERE shift_id = shift_id_param AND status = 'booked';
    
    -- Return true if there are available spots
    RETURN current_bookings < max_staff_count;
END;
$$ LANGUAGE plpgsql;

-- Function to calculate work hours
CREATE OR REPLACE FUNCTION calculate_work_hours(
    clock_in_param TIMESTAMP WITH TIME ZONE,
    clock_out_param TIMESTAMP WITH TIME ZONE,
    break_minutes_param INTEGER DEFAULT 0
)
RETURNS DECIMAL(5,2) AS $$
DECLARE
    total_minutes INTEGER;
    work_hours DECIMAL(5,2);
BEGIN
    -- Calculate total minutes worked
    total_minutes := EXTRACT(EPOCH FROM (clock_out_param - clock_in_param)) / 60;
    
    -- Subtract break time
    total_minutes := total_minutes - COALESCE(break_minutes_param, 0);
    
    -- Convert to hours with 2 decimal places
    work_hours := ROUND(total_minutes / 60.0, 2);
    
    RETURN GREATEST(work_hours, 0); -- Ensure non-negative
END;
$$ LANGUAGE plpgsql;

-- ========================================
-- INSERT SOME DEFAULT DATA
-- ========================================

-- Insert default app settings
INSERT INTO app_settings (key, value, description) VALUES
('office_location', '{"latitude": 0.0, "longitude": 0.0, "radius": 100}', 'Office location and geofence radius'),
('office_wifi', '{"ssid": "", "bssid": ""}', 'Office WiFi network details'),
('work_settings', '{"max_shift_hours": 12, "overtime_threshold": 8, "default_break_minutes": 30}', 'Work hour settings'),
('security_settings', '{"require_gps": true, "require_wifi": true, "require_device_check": true}', 'Security validation settings')
ON CONFLICT (key) DO NOTHING;

-- ========================================
-- HELPFUL VIEWS
-- ========================================

-- View for shift statistics
CREATE OR REPLACE VIEW shift_stats AS
SELECT 
    s.id,
    s.title,
    s.start_time,
    s.end_time,
    s.max_staff,
    COUNT(sb.id) as total_bookings,
    COUNT(sb.id) FILTER (WHERE sb.status = 'booked') as confirmed_bookings,
    (s.max_staff - COUNT(sb.id) FILTER (WHERE sb.status = 'booked')) as available_spots
FROM shifts s
LEFT JOIN shift_bookings sb ON s.id = sb.shift_id
WHERE s.is_active = true
GROUP BY s.id, s.title, s.start_time, s.end_time, s.max_staff;

-- View for user work summary
CREATE OR REPLACE VIEW user_work_summary AS
SELECT 
    u.id as user_id,
    u.full_name,
    COUNT(cr.id) as total_sessions,
    COALESCE(SUM(cr.total_hours), 0) as total_hours,
    COALESCE(SUM(cr.overtime_hours), 0) as total_overtime,
    COUNT(sb.id) as total_bookings,
    COUNT(sb.id) FILTER (WHERE sb.status = 'booked') as active_bookings
FROM users u
LEFT JOIN clock_records cr ON u.id = cr.user_id AND cr.total_hours IS NOT NULL
LEFT JOIN shift_bookings sb ON u.id = sb.user_id
WHERE u.is_active = true
GROUP BY u.id, u.full_name; 