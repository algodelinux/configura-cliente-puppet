configura-cliente-puppet
========================

DESCRIPCION
-------------------------------------------------------------------------------------------------------------

Destino : Equipos que queramos configurar como clientes del servidor puppet principal del centro (puppetinstituto).

Acción  : Configura como cliente puppet el equipo donde apliquemos configura-cliente-puppet.pp haciendo lo siguiente:

	* Se asegura que el paquete puppet esté instalado.
	* Crea el archivo de configuración de puppet /etc/puppet/puppet.conf con la siguiente configuración:

        	[main]
		logdir=/var/log/puppet
		vardir=/var/lib/puppet
		ssldir=/var/lib/puppet/ssl
		rundir=/var/run/puppet
		factpath=/lib/facter
		#pluginsync=true
		server=puppetinstituto
		runinterval=5400
		syslogfacility=
		report=true
			
		[master]
		templatedir=/var/lib/puppet/templates

		[agent]
		report = true
                # listen = true

	* Crea el archivo /etc/default/puppet que activa el servicio en el arranque:

	
		# Defaults for puppet - sourced by /etc/init.d/puppet

		# Start puppet on boot?
		START=yes

		# Startup options
		DAEMON_OPTS=""


	* Crea  el archivo /etc/escuela2.0" con el siguiente contenido:
		use=workstation

	* Crea el archivo /usr/lib/ruby/1.8/facter/leefichero.rb que lee los facter definidos en el fichero /etc/escuela2.0 

	* Asegura que exista el directorio de reports var/lib/puppet/reports

	* Borra el directorio /var/lib/puppet/ssl por si existieran certificados antigüos en el cliente

	* Inicia el servicio
-------------------------------------------------------------------------------------------------------------


INSTRUCCIONES DE USO
-------------------------------------------------------------------------------------------------------------

* Copiar configura-cliente-puppet.pp al equipo que queremos configurar

* Aplicar la configuración:

  puppet apply configura-cliente-puppet.pp
-------------------------------------------------------------------------------------------------------------


NOTA
-------------------------------------------------------------------------------------------------------------

Podemos usar este archivo para configurar cualquier cliente, con tan sólo cambiar el siguiente recurso:
file { "/etc/escuela2.0": content => "use=workstation",}  
-------------------------------------------------------------------------------------------------------------



Creado por:  
Esteban M. Navas Martín  
Administrador informático del IES Valle del Jerte.  
Plasencia  
12-Diciembre-2012  
  
Modificado: 08-Febrero-2013  
Deshabilitado el parámetro "listen = true" para evitar un bug por el que no
se ejecuta el agente puppet de forma automática.
