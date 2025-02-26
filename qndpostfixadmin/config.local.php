<?php
// Variables de entorno desde los secretos de Kubernetes
$CONF['database_type'] = getenv('POSTFIXADMIN_DB_TYPE') ?: 'sqlite';  // Tipo de base de datos
$CONF['database_host'] = getenv('POSTFIXADMIN_DB_HOST') ?: '';  // Dirección del servidor de base de datos
$CONF['database_port'] = getenv('POSTFIXADMIN_DB_PORT') ?: '';  // Puerto del servidor de base de datos
$CONF['database_user'] = getenv('POSTFIXADMIN_DB_USER') ?: '';  // Usuario de la base de datos
$CONF['database_password'] = getenv('POSTFIXADMIN_DB_PASSWORD') ?: '';  // Contraseña de la base de datos
$CONF['database_name'] = '/var/tmp/postfixadmin.db';  // Nombre de la base de datos (por defecto para SQLite)

// Servidor SMTP
$CONF['smtp_server'] = getenv('POSTFIXADMIN_SMTP_SERVER') ?: 'localhost';  // Dirección del servidor SMTP
$CONF['smtp_port'] = getenv('POSTFIXADMIN_SMTP_PORT') ?: 25;  // Puerto SMTP (por defecto es 25)

// Método de encriptación
$CONF['encrypt'] = getenv('POSTFIXADMIN_ENCRYPT') ?: 'md5crypt';  // Encriptación de contraseñas

// DKIM (Firma de correo electrónico)
$CONF['dkim'] = getenv('POSTFIXADMIN_DKIM') ?: 'NO';  // Habilitar o deshabilitar DKIM
$CONF['dkim_all_admins'] = getenv('POSTFIXADMIN_DKIM_ALL_ADMINS') ?: 'NO';  // Habilitar DKIM para todos los administradores

// Contraseña de configuración (setup)
$CONF['setup_password'] = getenv('POSTFIXADMIN_SETUP_PASSWORD') ?: 'changeme';  // Contraseña para acceder a setup.php

// Configuración básica de PostfixAdmin
$CONF['configured'] = true;  // No está configurado aún (debe ser cambiado a 'true' después de completar la configuración)

// Otros parámetros adicionales
$CONF['admin_username'] = 'admin';  // Nombre de usuario del administrador
$CONF['admin_password'] = 'adminpassword';  // Contraseña del administrador

// Opciones de idioma
$CONF['default_language'] = 'en';  // Idioma predeterminado

// Configuración de la zona horaria
$CONF['timezone'] = 'UTC';  // Zona horaria

// Opciones de seguridad
$CONF['encrypt'] = 'bcrypt';  // Método de encriptación de contraseñas
?>
