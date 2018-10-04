#!/bin/bash

# Server Variables
ip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
web_root="/opt/app-root"

# Database Variables
dbname="wordpress"
dbuser="$DATABASE_USERNAME"
dbpass="$DATABASE_PASSWORD"


# WordPress Variables
sitetitle="${APPLICATION_NAME}"
user="${WORDPRESS_USERNAME}"
email="${WORDPRESS_EMAIL}"
pass="${WORDPRESS_PASSWORD}"

# Download WP-CLI
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp


# Generate the wp-config.php file
wp core config --path="$web_root" --dbname="$dbname" --dbuser="$dbuser" --dbpass="$dbpass" --extra-php <<PHP
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', true);
define('WP_MEMORY_LIMIT', '256M');
PHP

# Install the WordPress database.
wp core install --path="$web_root" --url="$ip" --title="$sitetitle" --admin_user="$user" --admin_password="$pass" --admin_email="$email"


# Install CAWeb Theme and activate it
wp theme activate CAWeb
