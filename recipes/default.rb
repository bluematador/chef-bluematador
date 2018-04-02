#
# Cookbook:: bluematador_agent
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

case node[:platform]
when 'debian', 'ubuntu'
	apt_repository 'bluematador-agent' do
		repo_name 'Blue Matador, Inc.'
		uri 'https://apt.bluematador.com'
		keyserver 'hkp://keyserver.ubuntu.com:80'
		key 'BBED0D5A'
		deb_src true
	end
when 'centos', 'redhat', 'amazon', 'suse', 'opensuse'
	yum_repository 'bluematador-agent' do
	  description 'Blue Matador, Inc.'
	  baseurl 'http://yum.bluematador.com/'
	  priority '1'
	  gpgkey 'http://yum.bluematador.com/OPSBUNKER_RPM_KEY.public'
	  gpgcheck true
	  enabled true
	  action :create
	end
end

template '/etc/bluematador-agent/config.ini' do
	source 'config.ini.erb'
	mode 0640
	owner 'root'
	group 'root'
end

package 'Install bluematador-agent' do
	package_name 'bluematador-agent'
end

service 'bluematador-agent' do
	action [:enable, :start]
end