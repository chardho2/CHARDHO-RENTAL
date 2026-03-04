# Car Rental System - Deployment Guide

## Prerequisites

Before deploying, ensure you have the following installed:

1. **PHP 7.4+** (with extensions: mysqli, mbstring, iconv, curl)
2. **MySQL/MariaDB** (5.7+ or 10.2+)
3. **Apache/Nginx** (optional, for production)
4. **Composer** (optional, for dependency management)

## Quick Start (Development)

### Option 1: Automated Deployment
Run the main deployment script:
```bash
deploy.bat
```

This will:
- Check prerequisites
- Set up the database
- Configure the application
- Start the development server

### Option 2: Manual Setup

#### Step 1: Database Setup
```bash
setup-database.bat
```
Or manually:
```sql
CREATE DATABASE car_rental;
USE car_rental;
SOURCE Database/car_rental.sql;
```

#### Step 2: Configure Application
Edit `Files/car_rental/application/config/database.php`:
```php
$db['default'] = array(
    'hostname' => 'localhost',
    'username' => 'your_username',
    'password' => 'your_password',
    'database' => 'car_rental',
    // ... other settings
);
```

#### Step 3: Start Server
```bash
start-server.bat
```
Or manually:
```bash
cd Files/car_rental
php -S localhost:8000
```

#### Step 4: Access Application
Open your browser and navigate to:
```
http://localhost:8000
```

## Production Deployment

### Apache Configuration

1. **Copy files to web root:**
   ```bash
   xcopy /E /I Files\car_rental C:\xampp\htdocs\car-rental
   ```

2. **Configure Virtual Host** (httpd-vhosts.conf):
   ```apache
   <VirtualHost *:80>
       ServerName car-rental.local
       DocumentRoot "C:/xampp/htdocs/car-rental"
       
       <Directory "C:/xampp/htdocs/car-rental">
           Options Indexes FollowSymLinks
           AllowOverride All
           Require all granted
       </Directory>
   </VirtualHost>
   ```

3. **Update hosts file** (C:\Windows\System32\drivers\etc\hosts):
   ```
   127.0.0.1 car-rental.local
   ```

4. **Set Environment to Production** in `index.php`:
   ```php
   define('ENVIRONMENT', 'production');
   ```

### Nginx Configuration

```nginx
server {
    listen 80;
    server_name car-rental.local;
    root /var/www/car-rental;
    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php/$args;
    }

    location ~ \.php$ {
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

## File Permissions

Ensure the following directories are writable:

```bash
icacls Files\car_rental\application\logs /grant Everyone:(OI)(CI)F /T
icacls Files\car_rental\application\cache /grant Everyone:(OI)(CI)F /T
icacls Files\car_rental\public\assets\img /grant Everyone:(OI)(CI)F /T
```

## Security Checklist

- [ ] Change default admin password
- [ ] Set ENVIRONMENT to 'production' in index.php
- [ ] Remove or secure install/ directory
- [ ] Update base_url in application/config/config.php
- [ ] Enable HTTPS in production
- [ ] Set strong database passwords
- [ ] Disable error display in production
- [ ] Enable logging in application/config/config.php

## Troubleshooting

### Database Connection Issues
- Verify MySQL service is running
- Check database credentials in config/database.php
- Ensure database exists and is accessible

### Permission Errors
- Run scripts as Administrator
- Check file/folder permissions
- Verify web server user has write access

### 404 Errors
- Enable mod_rewrite in Apache
- Check .htaccess file exists
- Verify base_url in config.php

### Blank Page
- Check PHP error logs
- Enable error display temporarily
- Verify all required PHP extensions are installed

## Default Credentials

After installation, use these credentials to log in:
- **Admin Panel:** Check database for default admin user
- **Username:** admin (check database)
- **Password:** (check database or documentation)

**IMPORTANT:** Change default passwords immediately after first login!

## Support

For issues or questions:
1. Check the DEPLOYMENT.md file in Files/car_rental/
2. Review CodeIgniter documentation
3. Check application logs in application/logs/

## Project Structure

```
CAR-RENTAL/
├── Database/
│   └── car_rental.sql          # Database schema
├── Files/
│   └── car_rental/             # Main application
│       ├── application/        # CodeIgniter application
│       ├── system/             # CodeIgniter system files
│       ├── public/             # Public assets
│       └── index.php           # Entry point
├── deploy.bat                  # Main deployment script
├── start-server.bat            # Quick start script
├── setup-database.bat          # Database setup script
└── DEPLOYMENT-README.md        # This file
```

## Additional Notes

- The application uses CodeIgniter 3.x framework
- PHP built-in server is for development only
- Use Apache/Nginx for production deployments
- Regular backups of database are recommended
- Keep PHP and MySQL updated for security

---

**Version:** 1.0  
**Last Updated:** 2025
