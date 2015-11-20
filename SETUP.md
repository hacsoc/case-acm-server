# Setting this up on your own server
Right now, a lot of paths are hard coded, so you will need to work with that 
or submit a pull request to fix it.

## Requirements
 - docker
 - docker-compose
 - systemd
 - a recent kernel (3.19 or later will work)

## Create user
This one doesn’t matter.  I use `acm`

## Create directories
 - /srv/acm/
 - /srv/volume/

## Copy acm@.service to /etc/systemd/system/

# Setting up a service

## Write a docker-compose yml file
 - The name of the main container _must_ be the same as the name of the yml file 
 without the .yml
 - You _should_ use env files over env vars, stored in a folder with the name of 
 the service 
 - You _must_ have a file called `MAC` in the service\_name file that contains 
 the mac address for the service’s interface
 - Volumes _should_ go in /srv/volume/<service_name>/

# Starting a service
`systemctl start acm@<service_name>`

## Starting it at boot
`systemctl enable acm@<service_name>`
