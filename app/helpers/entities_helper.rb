module EntitiesHelper
  def entity_type_options
    Entity::TYPES.inject([]) {|a,t| a << [t.capitalize,t]}
  end
end
