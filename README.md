es_index_backup Cookbook
========================
Backup and restore any ElasticSearch index to and from S3.
It will:

1. Install AWS ElasticSearch plugin on the machine
2. Setup a new ElasticSearch repository and snapshot for the given index
3. Restore the index from S3 (If it was backed up before)
4. Setup a cronjob to backup the index into S3 every hour

Requirements
------------
You will need to have ElasticSearch installed on the machine. 

Attributes
----------
#### es_index_backup::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['es_index_backup']['es_host']</tt></td>
    <td>String</td>
    <td>host and port of es server</td>
    <td><tt>localhost:9200</tt></td>
  </tr>
  <tr>
    <td><tt>['es_index_backup']['repository_name']</tt></td>
    <td>String</td>
    <td>Name of the backup repository to create</td>
    <td><tt>repo-name</tt></td>
  </tr>
  <tr>
    <td><tt>['es_index_backup']['snapshot_name']</tt></td>
    <td>String</td>
    <td>Nmae of the snapshot to create</td>
    <td><tt>snapshot-name</tt></td>
  </tr>
  <tr>
    <td><tt>['es_index_backup']['index_name']</tt></td>
    <td>String</td>
    <td>Name of the ES index to backup</td>
    <td><tt>index-name</tt></td>
  </tr>
  <tr>
    <td><tt>['es_index_backup']['user']</tt></td>
    <td>String</td>
    <td>Name of the user to backup and restore with</td>
    <td><tt>some-user</tt></td>
  </tr>
  <tr>
    <td><tt>['es_index_backup']['dir']</tt></td>
    <td>String</td>
    <td>Direcotry to install backup and restore scripts to</td>
    <td><tt>/opt/es_index_backup</tt></td>
  </tr>
  <tr>
    <td><tt>['es_index_backup']['s3']['bucket']</tt></td>
    <td>String</td>
    <td>S3 bucket name to backup to</td>
    <td><tt>s3-bucket-name</tt></td>
  </tr>
  <tr>
    <td><tt>['es_index_backup']['s3']['dir']</tt></td>
    <td>String</td>
    <td>Directory inside the bucket to perform backup to</td>
    <td><tt>directory-in-s3</tt></td>
  </tr>
  <tr>
    <td><tt>['es_index_backup']['s3']['region']</tt></td>
    <td>String</td>
    <td>Region of the above bucket</td>
    <td><tt>us-west-2</tt></td>
  </tr>
</table>
#### es_index_backup::elastic_search_aws
You can either have a data bag "aws" with item "creds" with the following JSON:
```json
{"dashboards_backup": { "key": "XXXXXXXXX", "secret": "XXXXXXXX" }}
```
Or you can set up the key and secret with the following:
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['elasticsearch']['cloud']['aws']['access_key']</tt></td>
    <td>String</td>
    <td>AWS access key with permission to upload to S3</td>
  </tr>
  <tr>
    <td><tt>['elasticsearch']['cloud']['aws']['secret_key']</tt></td>
    <td>String</td>
    <td>AWS secret key with permission to upload to S3</td>
  </tr>
  <tr>
    <td><tt>['elasticsearch']['cloud']['aws']['region']</tt></td>
    <td>String</td>
    <td>The region of that S3 bucket</td>
  </tr>
</table>

Usage
-----
#### es_index_backup::default

This recipe works with a recipe that already installs ElasticSearch.
After you have ElasticSearch installed you can just `include_recipe 'es_index_backup'`.

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Erez Rabih
