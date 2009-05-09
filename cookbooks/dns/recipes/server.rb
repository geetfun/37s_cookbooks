require_recipe "djbdns::public_cache"
require_recipe "djbdns::internal_server"
require_recipe "djbdns::autozone" unless Chef::Config[:solo]