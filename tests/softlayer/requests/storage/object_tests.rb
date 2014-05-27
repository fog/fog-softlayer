#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

Shindo.tests("Fog::Storage[:softlayer] | container_tests", ["softlayer"]) do

  @storage = Fog::Storage[:softlayer]
  @container = 'example-testing'
  @object1 = 'test-object'
  @object2 = 'test-object-2'
  @storage.put_container(@container)

  tests('success') do

    tests("#put_object") do
      response = @storage.put_object(@container, @object1, 'The quick brown fox jumps over the lazy dog.')
      data_matches_schema(201) { response.status }
      data_matches_schema('') { response.body }
      @storage.put_object(@container, @object2, 'The quick brown fox jumps over the lazy dog, again.')
      data_matches_schema(201) { response.status }
      data_matches_schema('') { response.body }
    end

    tests("#get_object") do
      response = @storage.get_object(@container, @object2)
      data_matches_schema(200) { response.status }
      data_matches_schema('The quick brown fox jumps over the lazy dog, again.') { response.body }
    end

    tests("#delete_object") do
      pending if Fog.mocking?
    end

  end

  tests('failure') do
    tests("#get_object('non-existent-container', 'non-existent-object')") do
      data_matches_schema(404) { @storage.get_container('non-existent-container', 'non-existent-object').status }
    end

    tests("#get_object(#{@container}, 'non-existent-object')") do
      data_matches_schema(404) { @storage.get_container('non-existent-container', 'non-existent-object').status }
    end
  end
end
