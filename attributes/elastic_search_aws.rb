include_attribute 'elasticsearch'

creds = Chef::DataBagItem.load("aws", "creds")["dashboards_backup"] rescue {}

default.elasticsearch[:cloud][:aws][:access_key]     = creds["key"]
default.elasticsearch[:cloud][:aws][:secret_key]     = creds["secret"]
default.elasticsearch[:cloud][:aws][:region]         =  "us-west-2"

default.elasticsearch['plugins']['elasticsearch/elasticsearch-cloud-aws']['version'] = '2.1.0'
