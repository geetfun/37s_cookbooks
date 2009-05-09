require_recipe "djbdns::cache"
require_recipe "djbdns::internal_server"
require_recipe "djbdns::autozone" unless Chef::Config[:solo]