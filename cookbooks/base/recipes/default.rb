raise RuntimeError, "The node requires a role, one of: #{node[:roles].keys.join(',')}" unless node[:role] and node[:roles].has_key?(node[:role])

package "emacs22-nox"
package "vim"
package "curl"
package "man-db"
package "strace"
package "host"
package "lsof"
package "gdb"

require_recipe "timezone"
require_recipe "apt"
require_recipe "git"
require_recipe "postfix"
require_recipe "hosts"
require_recipe "ssh::server"

require_recipe "users"
require_recipe "sudo"

directory "/u" do
  action :create
  owner "root"
  group "admin"
  mode 0775
end

require_recipe "base::#{node[:role]}"