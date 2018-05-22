# Planificación proyecto

El proyecto se divide segun la manera en que el servidor Kerberos almacena su base de datos, a esto le llamamos _backend_.

## Backend Classic
Con el backend classic la base de datos se guarda en el mismo servidor Kerberos y por tanto tendría mas variedad en los modelos a implementar.

Separé las partes del backend clasico en las siguientes secciones:

- Administración de principals en la base de datos. ¿Es igual la manipulación de principals de servicios como de usuarios/hosts?
  
  Políticas. Directrices de seguridad en la gestión de cuentas.
  
  Bloqueo de cuentas. ¿Cuánto tiempo estara bloqueada una cuenta al no haber cumplido las directrices de una política?
  
  Contraseñas de usuarios, ficheros _stash_  para las contraseñas de administradores. ¿Es necesario que los principals de los servicios tengan contraseña?
  
  Permisos y acls. ¿Quién tiene permisos y qué permisos exactamente?
  
- Copias de seguridad e injección automatizada de usuarios y servicios con la utilización de scripts.
  Inserción masiva de usuarios proveniendo los datos de los mismos de ficheros externos.
  Inserción de los servicios que gestionara el realm.
  
- Servicios Kerberizados (unix, pam, ldap, xinetd)

## Backend LDAP
Se implementara el servidor Kerberos y el servidor LDAP en un mismo contenedor, actuando Kerberos como cliente del servidor LDAP.

