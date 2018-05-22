# Planificacio projecte

El proyecto se divide segun la manera en que el servidor Kerberos almacena su base de datos, a esto le llamamos _backend_.

## Backend Classic
Con el backend classic la base de datos se guarda en el mismo servidor Kerberos y por tanto tendria mas variedad en los modelos que implementaria.

Separe las partes del backend clasico en las siguientes secciones:

- Administracion de principals en la base de datos. ¿Es igual la manipulacion de principals de servicios como de usuarios/hosts?
  
  Politicas. Directrices de seguridad en la gestión de cuentas.
  
  Bloqueo de cuentas. ¿Cuanto tiempo estara bloqueada una cuenta al no haber cumplido las directrices de una politica?
  
  Contraseñas de usuarios, stashs para las contraseñas de administradores. ¿Es necesario que los principals de los servicios tengan contraseña?
  
  Permisos y acls. ¿Quien tiene permisos y que permisos exactamente?
  
- Copias de seguridad e injeccion automatizada de usuarios y servicios con la utilizacion de scripts.
  Insercion masiva de usuarios proveniendo los datos de los mismos de ficheros externos.
  Insercion de los servicios que gestionara el realm.
  
- Servicios Kerberizados (unix, pam, ldap, xinetd)

## Backend LDAP
Se implementara el servidor Kerberos y el servidor LDAP en un mismo contenedor, actuando Kerberos como cliente del servidor LDAP.

