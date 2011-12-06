SimpleNavigation::Configuration.run do |navigation|  
  navigation.items do |primary|
    primary.item :home, 'Home', root_path
  end
end
