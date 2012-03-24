class SerializedJSON < ActiveRecord::Base
  belongs_to :entity

  serialize :data, Hash
end

# todo i hate this and i think and it probably
# breaks things at some point...
SerializedJson = SerializedJSON
# due to error i was getting:
# Expected /home/bosco/photo/app/models/serialized_json.rb to define SerializedJson
