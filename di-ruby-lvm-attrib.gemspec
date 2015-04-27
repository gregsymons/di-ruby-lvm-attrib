$:.unshift(File.dirname(__FILE__) + '/lib')
Gem::Specification.new do |gem|  
  gem.authors       = ["Greg Symons", "Matthew Kent"]  
  gem.email         = ["mkent@magoazul.com", 'gsymons@gsconsulting.biz']  
  gem.description   = %q{A list of attributes for LVM objects}  
  gem.summary       = %q{A list of attributes for LVM objects}  
  gem.homepage      = "https://github.com/gregsymons/di-ruby-lvm-attrib"
  gem.executables   = [ 'generate_field_data' ]
 
  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "di-ruby-lvm-attrib"
  gem.require_paths = ["lib"]
  gem.version       = '0.0.18'
end
