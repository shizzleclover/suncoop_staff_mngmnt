# Admin User Setup Guide

This guide will help you create a test admin user for your SunCoopAtt system.

## 📋 Admin User Details

- **Email**: `admin@gmail.com`
- **Password**: `admin123`
- **Role**: `admin`
- **Full Name**: `System Administrator`

## 🚀 Setup Methods

### Method 1: Using Supabase Dashboard (Recommended)

This is the easiest and most reliable method:

1. **Run the Database Script**:
   - Open your Supabase project dashboard
   - Go to **SQL Editor**
   - Copy and paste the contents of `create_admin_simple.sql`
   - Click **Run** to execute the script

2. **Create the Auth User**:
   - Go to **Authentication** > **Users** in your Supabase dashboard
   - Click **"Add user"**
   - Fill in the details:
     - **Email**: `admin@gmail.com`
     - **Password**: `admin123`
     - **Auto Confirm User**: ✅ (check this box)
   - Click **"Create user"**

3. **Verify Setup**:
   - The user should appear in the Users list
   - You can now log in to your Flutter app with these credentials

### Method 2: Using SQL Script Only

If you prefer to do everything via SQL:

1. **Run the Complete Script**:
   - Open your Supabase project dashboard
   - Go to **SQL Editor**
   - Copy and paste the contents of `create_admin_user.sql`
   - Click **Run** to execute the script

2. **Check for Success**:
   - Look for success messages in the SQL output
   - If there are errors, try Method 1 instead

### Method 3: Using API (Advanced)

If you have your service role key:

1. **Run the Database Script**:
   ```bash
   # Run create_admin_simple.sql in Supabase SQL Editor first
   ```

2. **Create Auth User via API**:
   ```bash
   curl -X POST https://YOUR_PROJECT_ID.supabase.co/auth/v1/admin/users \
     -H "Authorization: Bearer YOUR_SERVICE_ROLE_KEY" \
     -H "Content-Type: application/json" \
     -d '{
       "email": "admin@gmail.com",
       "password": "admin123",
       "email_confirm": true,
       "user_metadata": {
         "full_name": "System Administrator"
       }
     }'
   ```

## 🧪 Test Data Included

The scripts also create sample shifts for testing:

1. **Morning Reception Shift**
   - Time: 9:00 AM - 5:00 PM (tomorrow)
   - Location: Main Office - Front Desk
   - Max Staff: 2
   - Rate: $15.50/hour

2. **Evening Cleaning Shift**
   - Time: 6:00 PM - 10:00 PM (tomorrow)
   - Location: Main Office - All Floors
   - Max Staff: 3
   - Rate: $18.00/hour

3. **Weekend Security Patrol**
   - Time: 10:00 PM - 6:00 AM (weekend)
   - Location: Building Perimeter
   - Max Staff: 2
   - Rate: $20.00/hour

## ✅ Verification Steps

After running the setup:

1. **Check Database**:
   ```sql
   SELECT id, email, full_name, role, is_active 
   FROM users 
   WHERE email = 'admin@gmail.com';
   ```

2. **Check Auth Users**:
   - Go to **Authentication** > **Users** in Supabase dashboard
   - Look for `admin@gmail.com` in the list

3. **Test Login**:
   - Open your Flutter app
   - Try logging in with:
     - Email: `admin@gmail.com`
     - Password: `admin123`
   - You should see the admin dashboard

## 🔧 Troubleshooting

### Issue: "User not found" when logging in
**Solution**: The auth user wasn't created. Use Method 1 to create it via the dashboard.

### Issue: "Access denied" after login
**Solution**: The user role isn't set to 'admin'. Run this SQL:
```sql
UPDATE users SET role = 'admin' WHERE email = 'admin@gmail.com';
```

### Issue: SQL script fails with permission errors
**Solution**: Make sure you're using the SQL Editor in Supabase dashboard with your project's service role permissions.

### Issue: User exists but can't access admin features
**Solution**: Check the user's role:
```sql
SELECT email, role FROM users WHERE email = 'admin@gmail.com';
```

## 🔒 Security Notes

- **Change the password** after initial setup for production use
- **Use a real email** for production admin accounts
- **Enable 2FA** for admin accounts in production
- **Regularly audit** admin actions using the audit logs

## 📱 Admin Features Available

Once logged in as admin, you'll have access to:

- **Admin Dashboard** - System overview and quick actions
- **User Management** - Create, edit, and manage staff accounts
- **Shift Management** - Create and manage work shifts
- **Shift Bookings** - View and manage all shift bookings
- **Time Tracking** - Monitor and adjust clock records
- **System Settings** - Configure app settings
- **Reports & Analytics** - View system statistics

## 🎯 Next Steps

After creating the admin user:

1. **Test all admin features** to ensure they work correctly
2. **Create additional staff users** for testing
3. **Configure system settings** (office location, WiFi, etc.)
4. **Set up real shifts** for your organization
5. **Train your team** on using the system

## 📞 Support

If you encounter any issues:

1. Check the troubleshooting section above
2. Verify your Supabase project configuration
3. Ensure all database migrations have been applied
4. Check the browser console for any JavaScript errors

---

**Happy testing with your SunCoopAtt admin account!** 🎉 