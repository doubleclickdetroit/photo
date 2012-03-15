class FormData < ActiveRecord::Base
  belongs_to :entity
  # belongs_to :form, :foreign_key => :entity_id, :class_name => 'Entity'
  
  serialize :data, Hash
end
