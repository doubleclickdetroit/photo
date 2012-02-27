module EntitiesHelper
  def entity_type_options
    Entity::TYPES.inject([]) {|a,t| t = t.to_s; a << [t,t]}
  end
end
