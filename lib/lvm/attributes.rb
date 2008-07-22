require 'yaml'

module LVM
  module Attributes
    VERSION = '0.0.1'

    def load(version, name)
      cwd = File.dirname(__FILE__)
      file = File.join(cwd, "attributes", version, name)

      return YAML.load_file(file)
    end
    module_function :load
  end # module Attributes 
end # module LVM
