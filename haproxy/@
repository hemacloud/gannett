# motd/libraries/matchers.rb
if defined?(ChefSpec)
  def install_haproxy(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:haproxy, :install, resource_name)
  end
end
