<?php
// Función para leer el contenido de los archivos de configuración de secretos
function get_secret($secret_file) {
    $path = "/etc/postfixadmin-secrets/" . $secret_file;
    if (file_exists($path)) {
        return trim(file_get_contents($path));
    }
    return null;
}

// Variables de entorno desde los secretos de Kubernetes
$CONF['database_type'] = get_secret('POSTFIXADMIN_DB_TYPE') ?: 'sqlite';  // Tipo de base de datos
$CONF['database_host'] = get_secret('POSTFIXADMIN_DB_HOST') ?: '';  // Dirección del servidor de base de datos
$CONF['database_port'] = get_secret('POSTFIXADMIN_DB_PORT') ?: '';  // Puerto del servidor de base de datos
$CONF['database_user'] = get_secret('POSTFIXADMIN_DB_USER') ?: '';  // Usuario de la base de datos
$CONF['database_password'] = get_secret('POSTFIXADMIN_DB_PASSWORD') ?: '';  // Contraseña de la base de datos
$CONF['database_name'] = '/var/tmp/postfixadmin.db';  // Nombre de la base de datos (por defecto para SQLite)

// Servidor SMTP
$CONF['smtp_server'] = get_secret('POSTFIXADMIN_SMTP_SERVER') ?: 'localhost';  // Dirección del servidor SMTP
$CONF['smtp_port'] = get_secret('POSTFIXADMIN_SMTP_PORT') ?: 25;  // Puerto SMTP (por defecto es 25)

// Método de encriptación
$CONF['encrypt'] = get_secret('POSTFIXADMIN_ENCRYPT') ?: 'md5crypt';  // Encriptación de contraseñas

// DKIM (Firma de correo electrónico)
$CONF['dkim'] = get_secret('POSTFIXADMIN_DKIM') ?: 'NO';  // Habilitar o deshabilitar DKIM
$CONF['dkim_all_admins'] = get_secret('POSTFIXADMIN_DKIM_ALL_ADMINS') ?: 'NO';  // Habilitar DKIM para todos los administradores

// Contraseña de configuración (setup)
$CONF['setup_password'] = get_secret('POSTFIXADMIN_SETUP_PASSWORD') ?: 'changeme';  // Contraseña para acceder a setup.php

// Configuración básica de PostfixAdmin
$CONF['configured'] = false;  // No está configurado aún (debe ser cambiado a 'true' después de completar la configuración)

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
