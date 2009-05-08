base Mash.new unless attribute?("base")
ddclient Mash.new unless attribute?("ddclient")
users Mash.new unless attribute?("users")
groups Mash.new unless attribute?("groups")
ssh_keys Mash.new unless attribute?("ssh_keys")
host_keys Mash.new unless attribute?("host_keys")
sudo Mash.new unless attribute?("sudo")
roles Mash.new unless attribute?("roles")
applications Mash.new unless attribute?("applications")
sites Mash.new unless attribute?("sites")
nameservers Array.new unless attribute?("nameservers")
postfix Mash.new unless attribute?("postfix")
hosts Mash.new unless attribute?("hosts")
public_domain String.new unless attribute?("public_domain")

base[:sysadmin_email] = "sysadmins@37signals.com"
base[:sysadmin_sms_email] = "sysadmins@37signals.com"
base[:campfire_subdomain] = "37s"
base[:campfire_email] = "monitoring@37signals.com"
base[:campfire_password] = ""
base[:monitoring_campfire_room] = "System Administration"
base[:clickatell_username] = "37signals"
base[:clickatell_api_id] = ""
base[:clickatell_password] = ""
base[:default_domain] = "37signals.com"
base[:gems_path] =  `gem env gemdir`.chomp!
base[:ruby_path] = `which ruby`.chomp!

ddclient[:dyndns_login] = "login"
ddclient[:dyndns_password] = "password"

nameservers ['10.249.65.224']
hosts[:entries] = [['10.249.65.224', 'noc']]
postfix[:myorigin] = fqdn
public_domain "euruko.37signals.com"

groups[:app]     = {:gid => 1003}
groups[:admin]   = {:gid => 4000}

roles[:dns]           = {:groups => [:admin], :sudo_groups => [:admin]}
roles[:noc]           = {:groups => [:admin, :app, :support], :sudo_groups => [:admin]}
roles[:app]           = {:groups => [:admin, :app], :sudo_groups => [:admin, :app]}
roles[:web]           = {:groups => [:admin, :app], :sudo_groups => [:admin, :app]}
roles[:memcache]      = {:groups => [:admin], :sudo_groups => [:admin]}

users[:app]    = {:password => "$1$FNYTkDAK$Dv6pg5wRrMo/aATt4e9zb.", :comment => "App User", :uid => 1003, :group => :app, :ssh_key_groups => [:app,,:admin]}
users[:site]   = {:password => "$1$FNYTkDAK$Dv6pg5wRrMo/aATt4e9zb.", :comment => "Site User", :uid => 4000, :group => :site, :ssh_key_groups => [:app,:admin]}

users[:joshua] = {:password => "$1$FNYTkDAK$Dv6pg5wRrMo/aATt4e9zb.", :comment => "Joshua Sierles", :uid => 3010, :group => :admin}

ssh_keys[:joshua]  = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAw942jLhdXBPHljWtE42B1XeFuWSJU/+w4pVTwdID6KEf8KF1cx/Jc0EJnA2ipMgJtUCJolWyt0PdGcqf8oE7UbrkzCW78g+zLa8muxUdHF6JK0b/nQW0plj8rg3rTxTz4lIi46AgW1iC9XXKlcX1IRC3w0Y9Lu+RMyGxdifFNHSj3g+Vd2QfHJBQkQz4Nx1ngT+y6y/966K/AIJHej67MmuCHRTxMKxX5vxmbvHP8WgSvylgx+mkTuYhUzGaQtvopM6zzXLfIsicnxVIu1hWjXlle55t0EamGysjGrJFbYiunbWDlwRfZOBe/ZKec5rBPLxwBC1xQ2F4sOJFUE+iUQ== jsierles@MacAir.local"

applications[:tadalist] = {:gems => ['fast_xs']}