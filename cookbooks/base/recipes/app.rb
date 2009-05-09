require_recipe "syslog::client"
require_recipe "nagios::client"
require_recipe "dns::client"
require_recipe "rails::apps"

package "mysql-client"
package "libmysqlclient15-dev"
gem_package "mysql"
package "mysql-server"
