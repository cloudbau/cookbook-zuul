# encoding: utf-8
#
# Cookbook Name:: zuul
# Attributes:: default
#
# Copyright 2012, Jay Pipes
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

default['zuul']['install_path'] = '/opt/zuul'
default['zuul']['repo_url'] = '/opt/zuul'
default['zuul']['conf_path'] = '/etc/zuul/zuul.conf'
default['zuul']['layout_conf_path'] = '/etc/zuul/layout.yaml'
default['zuul']['logging_conf_path'] = '/etc/zuul/logging.conf'
default['zuul']['pidfile'] = '/var/run/zuul/zuul.pid'

default['zuul']['user'] = 'zuul'
default['zuul']['group'] = 'zuul'
# Do not add trailing slashes to these paths
default['zuul']['state_dir'] = '/var/lib/zuul'
default['zuul']['log_dir'] = '/var/log/zuul'
default['zuul']['home'] = default['zuul']['state_dir']

# # No Gerrit cookbook exists. When it does, replace these hardcoded
# # values with defaults from the Gerrit default attributes
# default[:zuul][:gerrit][:url] = 'review.example.com'
# default[:zuul][:gerrit][:user] = 'zuul'

default['zuul']['vhost_name'] = node['fqdn']
default['zuul']['serveradmin'] = "webmaster@#{node['fqdn']}"
default['zuul']['gearman_server'] = '127.0.0.1'
default['zuul']['internal_gearman'] = true
default['zuul']['gerrit_server'] = ''
default['zuul']['gerrit_user'] = ''
default['zuul']['gerrit_baseurl'] = ''
default['zuul']['gerrit_sshkey'] = "#{node[:zuul][:home]}/.ssh/id_rsa"
default['zuul']['zuul_ssh_private_key'] = ''
default['zuul']['url_pattern'] = ''
default['zuul']['status_url'] = "https://#{node['fqdn']}/"
default['zuul']['zuul_url'] = ''
default['zuul']['git_source_repo'] = 'https://github.com/openstack-infra/zuul'
default['zuul']['job_name_in_report'] = false
default['zuul']['revision'] = 'master'
default['zuul']['statsd_host'] = ''
default['zuul']['git_email'] = ''
default['zuul']['git_name'] = ''
default['zuul']['smtp_host'] = 'localhost'
default['zuul']['smtp_port'] = 25
default['zuul']['smtp_default_from'] = "zuul@#{node['fqdn']}"
default['zuul']['smtp_default_to'] = "zuul.reports@#{node['fqdn']}"
default['zuul']['swift_authurl'] = ''
default['zuul']['swift_auth_version'] = ''
default['zuul']['swift_user'] = ''
default['zuul']['swift_key'] = ''
default['zuul']['swift_tenant_name'] = ''
default['zuul']['swift_region_name'] = ''
default['zuul']['swift_default_container'] = ''
default['zuul']['swift_default_logserver_prefix'] = ''
default['zuul']['swift_default_expiry'] = 7200
default['zuul']['proxy_ssl_cert_file_contents'] = ''
default['zuul']['proxy_ssl_key_file_contents'] = ''
default['zuul']['proxy_ssl_chain_file_contents'] = ''
