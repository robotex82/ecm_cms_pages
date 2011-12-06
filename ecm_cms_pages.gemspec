# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.authors = "Roberto Vasquez Angel"
  s.name = "ecm_cms_pages"
  s.summary = "Insert EcmCmsPages summary."
  s.description = "Insert EcmCmsPages description."
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version = "0.0.1"
  s.add_dependency('ecm_admin')  
end
