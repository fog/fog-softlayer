### Compute Examples

These examples all assume you have `~/.fog` which contains the following

   ```yaml  
   :softlayer_username: example-username
   :softlayer_api_key: 1a1a1a1a1a1a1a1a1a11a1a1a1a1a1a1a1a1a1 
   :softlayer_default_domain: example.com
  ```
  
#### Create a connection to SoftLayer Compute Service

```ruby
	require 'fog/softlayer'
	@sl = Fog::Compute[:softlayer]
```

#### Use the Models
1. List all servers

   ```ruby
   @sl.servers # list all servers
   @sl.servers.size # get a count of all servers 
   ```

1. Get a server's details

   ```ruby
   server = @sl.servers.get(<server id>)
   server.name # => 'hostname.example.com'
   server.created_at # => DateTime the server was created
   server.state # => 'Running', 'Stopped', 'Terminated', etc.
   ```

1. Provision a new VM with flavor (simple).

   ```ruby
     opts = {
     	:flavor_id => "m1.small",
     	:image_id => "23f7f05f-3657-4330-8772-329ed2e816bc",
     	:name => "test",
     	:datacenter => {:name=>"ams01"}
     }
     new_server = @sl.servers.create(opts)
     new_server.id # => 1337
   ```

1. Provision a new BMC instance with flavor (simple).

   ```ruby
     opts = {
     	:flavor_id => "m1.small",
     	:os_code => "UBUNTU_LATEST",
     	:name => "test1",
     	:datacenter => {:name=>"ams01"},
     	:bare_metal => true
     }
     @sl.servers.create(opts)
     new_server.id # => 1338
   ```

1. Provision a new VM without flavor.

   ```ruby
   	opts = {
     	:cpu => 2,
     	:ram => 2048,     	
     	:disk => [{'device' => 0, 'diskImage' => {'capacity' => 100 } }],
     	:ephemeral_storage => true,
     	:domain => "not-my-default.com",
     	:name => "hostname",
     	:os_code => "UBUNTU_LATEST",
     	:name => "test2",
     	:datacenter => {:name=>"ams01"},     
     }
   ```

1. Provision a BMC Instance without a flavor

   ```ruby
   opts = {
     	:cpu => 8,
     	:ram => 16348,     	
     	:disk => {'capacity' => 100 },
     	:ephemeral_storage => true,
     	:domain => "not-my-default.com",
     	:name => "hostname",
     	:os_code => "UBUNTU_LATEST",
     	:name => "test2",
     	:datacenter => {:name=>"ams01"},
     	:bare_metal => true
     }
   ```

1. Delete a VM or BMC instance.

   ```ruby
   	  @sl.servers.get(<server id>).destroy
   ```

