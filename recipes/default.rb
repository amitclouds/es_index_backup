#
# Cookbook Name:: es_index_backup
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user =  node.es_index_backup["user"]

include_recipe 'elasticsearch::aws'

service "elasticsearch" do
  action :start
end

chef_gem "httparty" do
  version "0.11.0" 
end
require 'httparty'

http_request "Create elastic search index" do
  action :put
  url "http://#{node.es_index_backup["es_host"]}/#{node.es_index_backup["index_name"]}"
  not_if {HTTParty.head("http://#{node.es_index_backup["es_host"]}/#{node.es_index_backup["index_name"]}").code == 200}
  retries 5
  retry_delay 5
end

http_request "Create backup repository on S3" do
  action :put
  url "http://#{node.es_index_backup["es_host"]}/_snapshot/#{node.es_index_backup["repository_name"]}"
  message ({
    type: :s3,
    settings: {
      bucket: node.es_index_backup["s3"]["bucket"],
      region: node.es_index_backup["s3"]["region"],
      base_path: node.es_index_backup["s3"]["dir"]
    }
  }.to_json)
  only_if {sleep 2}
end

directory node.es_index_backup["dir"] do
  owner user
  mode 0755
end


template "#{node.es_index_backup["dir"]}/backup_es_index.sh" do
  source 'backup_es_index.sh.erb'
  variables({
    repo: node.es_index_backup['repository_name'],
    snapshot: node.es_index_backup['snapshot_name'],
    index: node.es_index_backup['index_name']
  })
  mode 0755
  user user
end

template "#{node.es_index_backup["dir"]}/restore_es_index.sh" do
  source 'restore_es_index.sh.erb'
  variables({
    repo: node.es_index_backup['repository_name'],
    snapshot: node.es_index_backup['snapshot_name'],
    index: node.es_index_backup['index_name']
  })
  mode 0755
  user user
end

execute "./restore_es_index.sh" do
  cwd node.es_index_backup["dir"]
  user user
end

cron "backup index to s3" do
  minute '0'
  command "/bin/sh #{node.es_index_backup["dir"]}/backup_es_index.sh"
  user user
end
