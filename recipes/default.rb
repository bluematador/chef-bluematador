#
# Cookbook:: bluematador_agent
# Recipe:: default
#
# Copyright:: 2018, Blue Matador Inc., All Rights Reserved.

case node[:platform]
when 'debian', 'ubuntu'
	apt_update 'update' do
		action :update
	end
	package 'apt-transport-https' do
		action :install
	end

	apt_repository 'bluematador-agent' do
		repo_name 'Blue Matador, Inc.'
		components ['stable', 'main']
		distribution nil
		uri 'https://apt.bluematador.com'
		keyserver 'hkp://keyserver.ubuntu.com:80'
		key 'BBED0D5A'
	end
when 'centos', 'redhat', 'amazon', 'fedora'
	yum_repository 'bluematador-agent' do
	  description 'Blue Matador, Inc.'
	  baseurl 'http://yum.bluematador.com/'
	  priority '1'
	  gpgkey 'http://yum.bluematador.com/OPSBUNKER_RPM_KEY.public'
	  gpgcheck true
	  enabled true
	  action :create
	end
when 'suse', 'opensuseleap'
	zypper_repository 'bluematador-agent' do
	  description 'Blue Matador, Inc.'
	  baseurl 'http://yum.bluematador.com/'
	  priority 1
	  gpgcheck false # because zypper fails to validate RPMs
	  autorefresh true
	  enabled true
	  action :create
	end

	# because opensuse by default doesn't have /etc/rc.status, which is needed
	# for the init.d script
	zypper_package 'aaa_base' do
		action :install
	end
end

package 'Install bluematador-agent' do
	package_name 'bluematador-agent'
	action :upgrade
end

template '/etc/bluematador-agent/config.ini' do
	source 'config.ini.erb'
	mode 0640
	owner 'root'
	group 'root'
end

service 'bluematador-agent' do
	# CentOS 7 only has systemd, but chef for some reason does not pick that
	# as the provider
	if node[:platform] == 'centos' && node[:platform_version].to_f >= 7.0
		provider Chef::Provider::Service::Systemd
	end
	action [:enable, :start]
end