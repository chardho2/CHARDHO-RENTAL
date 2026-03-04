# Prerequisites Installation Guide

## Current Status
PHP is not installed on your system. You need to install it before deploying.

## Quick Install Options

### Option 1: XAMPP (Recommended - All-in-One)
1. Download XAMPP from: https://www.apachefriends.org/
2. Install to C:\xampp
3. XAMPP includes: PHP, MySQL, Apache
4. Start Apache and MySQL from XAMPP Control Panel

### Option 2: Standalone PHP + MySQL
1. **PHP:**
   - Download from: https://windows.php.net/download/
   - Extract to C:\php
   - Add C:\php to System PATH
   
2. **MySQL:**
   - Download from: https://dev.mysql.com/downloads/installer/
   - Install MySQL Server
   - Remember root password

### Option 3: Laragon (Alternative)
1. Download from: https://laragon.org/download/
2. Install - includes PHP, MySQL, Apache
3. Auto-configures everything

## After Installation

Run this command to verify:
```
php -v
mysql --version
```

Then run:
```
deploy.bat
```

## Manual Preview (Without Scripts)

If you have a web server already:
1. Copy Files/car_rental to your web root
2. Import Database/car_rental.sql to MySQL
3. Configure application/config/database.php
4. Access via browser: http://localhost/car_rental
