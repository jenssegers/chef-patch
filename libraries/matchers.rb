if defined?(ChefSpec)
  def run_append_line(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:append_line, :run, resource_name)
  end

  def run_replace(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:replace, :run, resource_name)
  end

  def run_replace_line(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:replace_line, :run, resource_name)
  end
end
