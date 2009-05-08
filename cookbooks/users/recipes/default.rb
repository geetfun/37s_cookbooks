include_recipe "ssh_keys"

role[:groups].each do |group_name|

  users = node[:users].find_all { |u| u.last[:group] == group_name }

  group group_name.to_s do
    gid node[:groups][group_name][:gid]
  end

  users.each do |u, config|
    user u do
      comment config[:comment]
      uid config[:uid]
      gid config[:group].to_s
      home "/home/#{u}"
      shell "/bin/bash"
      password config[:password]
      supports :manage_home => true
    end

    directory "/home/#{u}/.ssh" do
      action :create
      owner u
      group config[:group].to_s
      mode 0700
    end
    
    add_keys u do
      conf config
    end
  end  
end

# Remove initial setup user and group.
user  "ubuntu" do
  action :remove
end

group "ubuntu" do
  action :remove
end