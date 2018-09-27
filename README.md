# case-acm-server
Code and issues for the ACM docker server

## Overview
This uses docker-compose and systemd along with a couple short bash scripts to
start and stop services running in docker containers.

## Requirements
Things are a bit specific to the ACM server's set up for now, so this will be
rather un-flexable.

1. docker-compose in /usr/local/bin
2. YAML configs and net\_\*.sh scripts in /srv/acm/
3. acm@.server in /etc/systemd/system/
4. A folder for each service with the same name as the service, containing
necessary \*.env files and a single file called MAC with the services'
container's mac address (as registered w/ CWRU ITS).
5. Necessary mountpoints in /srv/volume/

### Disalowed names
Service names may not:

1. be "bin" (not case sensitive)
2. be "default" (not case sensitive)
3. be any other service name (not case sensitive)
4. contain "\_", " ", "+", "@", "#", "$", "/", or "\"

## Management script
The script `server` can control stopping, starting, restarting, and updating
services.  The `server_default` script should be symlinked to `server_<name>`,
where <name> is the name of the service, and can manage the <name> service
(specified by <name>.yml).

To add a script, create a group <name>, add it to sudoers with the ability to
run `server_<name>` with NOPASSWD, and add the users that need to manage that
service to the proper group.

For now, read the `server` and `server_default` scripts to see how they work
(they're not too long).
