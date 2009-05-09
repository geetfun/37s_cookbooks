chef Mash.new unless attribute?("chef")
chef[:client_version] = "0.6.2"
chef[:client_path] = `which chef-client`.chomp
chef[:client_interval] = "20"
chef[:client_splay] = "5"
chef[:log_path] = "/var/log/chef/client.log"