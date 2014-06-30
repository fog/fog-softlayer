#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

# necessary when requiring fog without rubygems while also
# maintaining ruby 1.8.7 support (can't use require_relative)
__LIB_DIR__ = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift __LIB_DIR__ unless $LOAD_PATH.include?(__LIB_DIR__)

# Use fog and core
require 'fog/core'
require 'fog'

# Previously treated as "core"
# data exchange specific (to be extracted and used on a per provider basis)
require 'fog/xml'
require 'fog/json'

require 'fog/softlayer'
