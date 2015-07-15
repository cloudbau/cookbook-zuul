# encoding: utf-8
#
# Cookbook Name:: zuul
# Recipe:: webapp
#
# Chefified from https://github.com/openstack-infra/puppet-zuul/
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'apache2'
include_recipe 'apache2::mod_cgi'
include_recipe 'apache2::mod_proxy'
include_recipe 'apache2::mod_proxy_http'

directory '/var/lib/zuul/www'
directory '/var/lib/zuul/www/lib'

package 'libjs-jquery'

file '/var/lib/zuul/www/jquery.min.js' do
  action :delete
end

link '/var/lib/zuul/www/lib/jquery.min.js' do
  to '/usr/share/javascript/jquery/jquery.min.js'
end

git '/opt/twitter-bootstrap' do
  action :sync
  revision 'v3.1.1'
  repository 'https://github.com/twbs/bootstrap.git'
end

file '/var/lib/zuul/www/bootstrap' do
  action :delete
end

link '/var/lib/zuul/www/lib/bootstrap' do
 to '/opt/twitter-bootstrap/dist'
end

git '/opt/jquery-visibility' do
  action :sync
  revision 'master'
  repository 'https://github.com/mathiasbynens/jquery-visibility.git'
end

file '/var/lib/zuul/www/jquery-visibility.min.js' do
  action :delete
end

package 'yui-compressor'

execute 'install-jquery-visibility' do
  command 'yui-compressor -o /var/lib/zuul/www/lib/jquery-visibility.js /opt/jquery-visibility/jquery-visibility.js'
  environment "PATH" => '/bin:/usr/bin'
  # Todo(JR): find out how this works
  # refreshonly => true
  # subscribes git '/opt/jquery-visibility']
end

git '/opt/graphitejs' do
  revision 'master'
  repository 'https://github.com/prestontimmons/graphitejs.git'
end

file '/var/lib/zuul/www/jquery.graphite.js' do
  action :delete
end

link '/var/lib/zuul/www/lib/jquery.graphite.js' do
  to '/opt/graphitejs/jquery.graphite.js'
end

link '/var/lib/zuul/www/index.html' do
  to '/opt/zuul/etc/status/public_html/index.html'
end

link '/var/lib/zuul/www/styles' do
  to '/opt/zuul/etc/status/public_html/styles'
end

link '/var/lib/zuul/www/zuul.app.js' do
  to '/opt/zuul/etc/status/public_html/zuul.app.js'
end

link '/var/lib/zuul/www/jquery.zuul.js' do
  to '/opt/zuul/etc/status/public_html/jquery.zuul.js'
end

link '/var/lib/zuul/www/images' do
  to '/opt/zuul/etc/status/public_html/images'
end

web_app "zuul" do
  template 'zuul.vhost.erb'
  serveradmin node['zuul']['serveradmin']
  vhost_name node['zuul']['vhost_name']
end
