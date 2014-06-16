### Tags Examples

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

#### Tags with Servers
1. Add some tags to a server.

   ```ruby
   server = @sl.servers.get(1234567) # get the server in question
   server.add_tags(['sparkle', 'motion']) # => true
   ```

1. Verify that the tags stuck.

   ```ruby
   server.tags # => ["sparkle", "motion"]
   ```

1. Remove a tag.

   ```ruby
   server.tags # => ["sparkle", "motion"]
   server.delete_tags(["sparkle"]) # => true
   server.tags # => ["motion"]
   ```

1. Put it back.

   ```ruby
   server.tags # => ["motion"]
   server.add_tags(['sparkle']) # => true     
   server.tags # => ["sparkle", "motion"]
   ```

1. Get servers tagged by a single tag.

   ```ruby
   	@sl.servers.tagged_with(['foo']) # => [<Fog::Compute::Softlayer::Server>, <Fog::Compute::Softlayer::Server>, ...]
   ```

1. Get servers tagged by multiple tags (tag OR tag OR ...).

   ```ruby
   	@sl.servers.tagged_with(['foo','bar']) # => [<Fog::Compute::Softlayer::Server>, <Fog::Compute::Softlayer::Server>, ...]
   ```

1. List all tags on account.

   ```ruby
   	  @sl.tags.all # => [<Fog::Compute::Softlayer::Tag>, <Fog::Compute::Softlayer::Tag>, ...]
     ```
1. Anatomy of a Tag object.

	```ruby
	<Fog::Compute::Softlayer::Tag
    id=32850, # SoftLayer assigned ID
    name="sparkle", # the tag itself
    referenceCount=2, # number of SL API objects that "have" this tag
    resource_id=nil, # fog-softlayer property used by models
    internal=0 # SoftLayer API flag indicating user assigned (0) or system assigned (1)
  	>
	```
	
1. Miscellany

	```ruby
	tag = @sl.tags.get(32850)
	tag.references # => [<Fog::Compute::Softlayer::Server>, <Fog::Compute::Softlayer::Server>, ...]
	```
