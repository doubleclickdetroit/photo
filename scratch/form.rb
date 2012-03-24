# so... forms. i feel like i had a great idea about this and
# forgot it. what im thinking right now is that what we need
# is an entity to tie together a form_type and form_data.
# the title/text for the form will be persisted in the table
# entities, the form_type declares the fields, widths, etc
# and the form_data is the individual responses/pre-pop vals

# as for the way we store this, all i can think of is crap.
# right now im thinking we just serialize the form_type as
# a hash or we just save the straight json.
#
# i guess the straight json would be silly, since the form
# data would need to get dropped into the json for a given
# request and we might as well have ruby parsed it out in 
# order to do that... so, tentatively, a Hash it is...


class Form < Entity
  has_one :form_data

  def to_hash
    # dumps self to hash
    # results in hash form of scratch/form_entity.json
  end

  def to_json
    self.to_hash.to_json
  end
end

# Datum? ...derp
class FormData < AR::BASE
  belongs_to :form_type
  belongs_to :form
end

class FormType < AR::BASE
  belongs_to :form
  has_many :form_data # i think it'll look for 'datum' lol

  # maybe this has some kind of validation on 
  # the incoming json to make sure its ok?...
end


# this will facilitate aggregate views of responses from
# form_types as it has_many form_data


# tl;dr Form will marry FormData to FormType and in order
# to serve up the combined json


# ok, another thought. both of these proposed types will be
# storing serialized JSON, so maybe SerializedJSON should be
# an AR class that these both inherit from and the
# subclasses can just take care of the #to_hash stuff...
#
# also, im pretty sure the Form is going to need to has_one
# :form_type and then have the FormType do the lookup for
# an associated FormDatum, because the From will always have
# a FormType but may or may not have FormData
#
# i feel like theres some sort of duck-typing thing we can
# do here to just let FormType figure this all out on its
# own
#
#
# so... something like

class Form < Entity
  has_one :form_type
  has_one :form_data

  def to_hash
    something.something.attributes
    .merge(form_type.to_hash(form_data))
  end
end

class FormType < AR::BASE
  belongs_to :form
  # this will have to be some stupid polymorphic
  # association noise due to the use of STI
  has_many :form_data

  def to_hash(form_data)
    # merge FormData vals into FormType
  end
end

class FormDatum < AR::BASE
  belongs_to :form
end
