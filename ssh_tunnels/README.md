Description
===========

Configure, run and manage ssh tunnels. Uses god monitoring tool for autorestart so god recipe will be applied as dependency.

Requirements
============

OpenSSH client should be installed and available as 'ssh' binary in PATH's directories.
Platform:

    Debian/Ubuntu
    RHEL/CentOS/Scientific
    Fedora
    FreeBSD


Attributes and usage
==========

Default recipe 'recipe[ssh_tunnels]' used for adding ssh tunnels to the node. Tunnels properties described in 'tunnels' attribute. It is an array. Each member of this array defines one tunnel.
For example:

	"tunnels": [
	  {
	    "ssh_gateway": "192.168.0.150",
	    "ssh_port": "22",
	    "ssh_user": "downloader",
	    "ssh_key": "/root/.ssh/id_dsa",
	    "local_port": "8888",
	    "remote_host": "ya.ru",
	    "remote_port": "80",
	    "StrictHostKeyChecking": "no"
	  },
	  ....
	]

First member of the example means that SSH connection will be established to 192.168.0.150 address and port 22 with  'downloader' username. The private key /root/.ssh/id_dsa will be used for auth. Local port 8888 will be forwarded to ya.ru:80. Local port value used as tunnel ID in other recipes in this Cookbook.
NOTE: This recipe doesn't manage private key and known_hosts file. Option 'StrictHostKeyChecking' can be used to eliminate 'yes/no' prompt about known_hosts but it isn't safety. Chef-solo example json file is "../sshtun_add.json""

Remove recipe - "recipe[ssh_tunnels::remove]". Used to stop and remove tunnels from god's monitoring. IDs (local ports) of tunnels should be defined in 'tunnels2remove' atribute. Chef-solo example json file is "../sshtun_remove.json"

Restart recipe "recipe[ssh_tunnels::restart]" . Used to restart tunnels.  Tunnels to restart should be defined in 'tunnels2restart' atribute. Chef-solo example json file is "../sshtun_restart.json"

Restart all recipe - recipe[ssh_tunnels::restart_all]. Used to restart all present ssh tunnels. Has no specific attributes. Chef-solo example json file is "../sshtun_restart_all.json"
