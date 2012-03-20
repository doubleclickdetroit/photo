class Asset < ActiveRecord::Base 
  belongs_to :entity
  has_attached_file :file, :prefix => false

  delegate :url, :to => :file, :prefix => true

  # allow the following to be used without the redundant
  # prefix 'file_' they come with from paperclip
  %w(file_name file_size content_type url).each do |m_name|
    new, old = m_name.intern, ("file_"+m_name).intern
    define_method new, lambda { self.send old }
  end
end
