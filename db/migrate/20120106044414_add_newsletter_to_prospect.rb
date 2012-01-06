class AddNewsletterToProspect < ActiveRecord::Migration
  def change
    add_column :prospects, :newsletter, :boolean
  end
end
