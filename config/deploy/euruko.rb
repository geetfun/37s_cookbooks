ssh_options[:keys] = [File.join(ENV["HOME"], ".ec2", "euruko.pem"), File.join(ENV["HOME"], ".ssh", "id_rsa")] 

set :user, ENV['USER']
role :app, "noc.euruko.37signals.com"

require 'erb'
require 'right_aws'

ROLE_IMAGE_MAP = {:app => {:ami => "ami-7cfd1a15", :type => 'm1.small'},
                  :noc => {:ami => "ami-7cfd1a15", :type => 'm1.small'}}

namespace :ec2 do
  desc "Launch an instance and bootstrap it for chef"
  task :launch do
    raise(ArgumentError, "Please set HOSTNAME, ROLE, AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY") unless ENV['HOSTNAME'] && ENV['ROLE'] && ENV['AWS_ACCESS_KEY_ID'] && ENV['AWS_SECRET_ACCESS_KEY']
    @hostname = ENV['HOSTNAME']
    @domain = "euruko.37signals.com"
    public_domain = "euruko.37signals.com"
    @public_fqdn = ENV['PUBLIC_FQDN'] || "#{@hostname}.#{public_domain}"
    @role = ENV['ROLE']
    @primary_nameserver_ip = "10.249.65.224"
    @validation_token = "21f8f8d29606dbf5143038c13bb567f8"
    
    config = ROLE_IMAGE_MAP[@role.to_sym]
    output = ERB.new(File.read(File.dirname(__FILE__)+"/../bootstrap.erb")).result(binding)
    
    ec2 = RightAws::Ec2.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    result = ec2.launch_instances(config[:ami], :group_ids => ['default', @role, @hostname], :instance_type => config[:type], :key_name => 'ec2', :user_data => output)
    puts result.inspect
  end
end

# noc rebuild steps
# gem install merb-core merb-haml merb-helpers merb-slices -v 1.0.10 --no-rdoc --no-rdoc
# gem install cucumber rspec --no-rdoc --no-ri
# ln -s /var/chef/couchdb /var/lib/couchdb