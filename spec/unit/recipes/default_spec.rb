#
# Cookbook:: bluematador_agent
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bluematador_agent::default' do

  debian_runners = [
    { platform: 'ubuntu', version: '16.04' },
    { platform: 'debian', version: '7.11' },
  ]

  debian_runners.each do |s|
    context "When all attributes are default, on a #{s[:platform]} #{s[:version]}" do

      let(:chef_run) do
        runner = ChefSpec::ServerRunner.new(platform: s[:platform], version: s[:version])
        runner.converge(described_recipe)
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it 'configures the apt repo' do
        expect(chef_run).to add_apt_repository 'bluematador-agent'
      end

      it 'installs bluematador-agent' do
        expect(chef_run).to upgrade_package 'bluematador-agent'
      end

      it 'enables bluematador-agent service' do
        expect(chef_run).to enable_service 'bluematador-agent'
      end

      it 'starts the bluematador-agent service' do
        expect(chef_run).to start_service 'bluematador-agent'
      end

      it 'creates the config file' do
        expect(chef_run).to create_template '/etc/bluematador-agent/config.ini'
      end
    end
  end


  redhat_runners = [
    { platform: 'centos', version: '5.11' },
    { platform: 'redhat', version: '5.11' },
    { platform: 'suse', version: '11.4' },
    { platform: 'opensuse', version: '42.2' },
    { platform: 'fedora', version: '26' },
  ]

  redhat_runners.each do |s|
    context "When all attributes are default, on a #{s[:platform]} #{s[:version]}" do

      let(:chef_run) do
        runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '5.11')
        runner.converge(described_recipe)
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it 'adds the yum repo' do
        expect(chef_run).to create_yum_repository 'bluematador-agent'
      end

      it 'installs bluematador-agent' do
        expect(chef_run).to upgrade_package 'bluematador-agent'
      end

      it 'enables bluematador-agent service' do
        expect(chef_run).to enable_service 'bluematador-agent'
      end

      it 'starts the bluematador-agent service' do
        expect(chef_run).to start_service 'bluematador-agent'
      end

      it 'creates the config file' do
        expect(chef_run).to create_template '/etc/bluematador-agent/config.ini'
      end
    end
  end
end
