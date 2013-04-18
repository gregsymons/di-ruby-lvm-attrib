require 'yaml'

module LVM
  module Attributes
    VERSION = '0.0.10'

    def load(version, name)
      cwd = File.dirname(__FILE__)

      # was going to be symlinks, but rubygems didn't seem to want to package
      # them
      if version == "2.02.28"
        version = "2.02.27"
      elsif ((31..39).map { |x| "2.02.#{x}" }).include?(version)
        version = "2.02.30"
      end

      file = File.join(cwd, "attributes", version, name)

      return YAML.load_file(file)
    end
    module_function :load
  end # module Attributes 
end # module LVM
