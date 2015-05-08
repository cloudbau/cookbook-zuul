#
# Cookbook Name:: zuul
# Recipe:: server
#
# Copyright 2012, Jay Pipes
# Copyright 2015, Edmund Haselwanter
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

include_recipe 'git'
include_recipe 'python'
include_recipe 'build-essential::default'

pkey = "#{node[:zuul][:home]}/.ssh/id_rsa"

user node[:zuul][:user] do
  home node[:zuul][:home]
end

directory node[:zuul][:home] do
  recursive true
  owner node[:zuul][:user]
  group node[:zuul][:group]
end

directory "#{node[:zuul][:home]}/.ssh" do
  mode 0700
  owner node[:zuul][:user]
  group node[:zuul][:group]
end

directory '/etc/zuul'

execute "ssh-keygen -f #{pkey} -N ''" do
  user node[:zuul][:user]
  group node[:zuul][:group]
  not_if { File.exist?(pkey) }
end

ruby_block 'store zuul ssh pubkey' do
  block do
    node.default[:zuul][:pubkey] = File.open("#{pkey}.pub") { |f| f.gets }
  end
end

git node['zuul']['install_path'] do
  repository node['zuul']['git_source_repo']
  reference 'master'
  action :sync
  notifies :install, "python_pip[#{node['zuul']['install_path']}]"
end

package 'python-daemon'
package 'python-lxml'
package 'python-paramiko'
package 'python-paste'
package 'python-webob'
package 'python-yaml'
python_pip 'yappi'
package 'yui-compressor'

python_pip node['zuul']['install_path'] do
  options '-U'
end

template node['zuul']['conf_path'] do
  source 'zuul.conf.erb'
  notifies :restart, 'service[zuul]'
  variables(
    zuul_layout_conf_path: node['zuul']['layout_conf_path'],
    zuul_logging_conf_path: node['zuul']['logging_conf_path'],
    zuul_pidfile: node['zuul']['pidfile'],
    zuul_state_dir: node['zuul']['state_dir'],
    serveradmin: node['zuul']['serveradmin'],
    gearman_server: node['zuul']['gearman_server'],
    internal_gearman: node['zuul']['internal_gearman'],
    gerrit_server: node['zuul']['gerrit_server'],
    gerrit_user: node['zuul']['gerrit_user'],
    gerrit_baseurl: node['zuul']['gerrit_baseurl'],
    gerrit_sshkey: node['zuul']['gerrit_sshkey'],
    # not used? zuul_ssh_private_key: node['zuul']['zuul_ssh_private_key'],
    url_pattern: node['zuul']['url_pattern'],
    status_url: node['zuul']['status_url'],
    zuul_url: node['zuul']['zuul_url'],
    git_source_repo: node['zuul']['git_source_repo'],
    job_name_in_report: node['zuul']['job_name_in_report'],
    revision: node['zuul']['revision'],
    statsd_host: node['zuul']['statsd_host'],
    git_email: node['zuul']['git_email'],
    git_name: node['zuul']['git_name'],
    smtp_host: node['zuul']['smtp_host'],
    smtp_port: node['zuul']['smtp_port'],
    smtp_default_from: node['zuul']['smtp_default_from'],
    smtp_default_to: node['zuul']['smtp_default_to'],
    swift_authurl: node['zuul']['swift_authurl'],
    swift_auth_version: node['zuul']['swift_auth_version'],
    swift_user: node['zuul']['swift_user'],
    swift_key: node['zuul']['swift_key'],
    swift_tenant_name: node['zuul']['swift_tenant_name'],
    swift_region_name: node['zuul']['swift_region_name'],
    swift_default_container: node['zuul']['swift_default_container'],
    swift_default_logserver_prefix: node['zuul']['swift_default_logserver_prefix'],
    swift_default_expiry: node['zuul']['swift_default_expiry'],
    proxy_ssl_cert_file_contents: node['zuul']['proxy_ssl_cert_file_contents'],
    proxy_ssl_key_file_contents: node['zuul']['proxy_ssl_key_file_contents'],
)
end

template node['zuul']['logging_conf_path'] do
  source 'logging.conf.erb'
  notifies :restart, 'service[zuul]'
  variables(
    zuul_log_dir: node['zuul']['log_dir']
  )
end

template node['zuul']['layout_conf_path'] do
  source 'layout.yaml.erb'
  notifies :restart, 'service[zuul]'
end

case node.platform
when 'ubuntu', 'debian'
  install_starts_service = true
when 'centos', 'redhat'
  pid_file = '/var/run/zuul.pid'
  install_starts_service = false
end

template '/etc/init.d/zuul' do
  source 'zuul.init.erb'
  mode 0755
end

template '/etc/init.d/zuul-merger' do
  source 'zuul-merger.init.erb'
  mode 0755
end

service 'zuul' do
  supports [:stop, :start, :restart, :status]
  status_command "test -f #{pid_file} && kill -0 `cat #{pid_file}`"
  action :nothing
end
