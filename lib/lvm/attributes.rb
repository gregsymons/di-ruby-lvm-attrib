require 'yaml'

module LVM
  module Attributes
    VERSION = '0.0.21'
    
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

      begin
        return YAML.load_file(file)
      rescue Errno::ENOENT => e
        raise ArgumentError.new("Unable to load lvm attributes [#{name}] for version [#{version}]. " + 
          "The version/object may not be supported or you may need to upgrade the di-ruby-lvm-attrib gem. Error [#{e.message}]")
      end
    end
    module_function :load
  end # module Attributes 
end # module LVM
