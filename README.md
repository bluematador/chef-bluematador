# bluematador_agent

Installs/Configures the Blue Matador Agent.

## Requirements

 * chef >= 12.1

## Platforms

 * Amazon Linux
 * CentOS
 * Debian
 * RedHat
 * Ubuntu

## Usage

 1. If you are using [https://docs.chef.io/berkshelf.html](Berkshelf), add the `bluematador_agent` cookbook to your Berksfile. You can also install the cookbook in to your repository using knife `knife cookbook site install bluematador_agent` or clone this repo.
 1. Set the account_id, api_key, and env attributes.
    ```
    node['bluematador_agent']['api_key'] = '<your api key>'
    node['bluematador_agent']['account_id'] = '<your account id>'
    node['bluematador_agent']['env'] = node['chef_environment']
    ```
 1. Upload the cookbook to your Chef server with `berks upload` or `knife cookbook upload bluematador_agent`
 1. Edit your node's runlist to include `recipe[bluematador_agent]`
 1. Wait for `chef-client` to run

## Additional Information

To get your account_id and api_key, visit the [Install Agent](https://app.bluematador.com/ur/app#/setup/agent) page of our app.

For more information, visit the [Blue Matador Website](https://www.bluematador.com)
