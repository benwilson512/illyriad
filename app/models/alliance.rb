# == Schema Information
#
# Table name: alliances
#
#  id         :integer(4)      not null, primary key
#  game_id    :integer(4)
#  name       :string(255)
#  ticker     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Alliance < ActiveRecord::Base
  
  has_many :players
  
  named_scope :by_name, :order => :name
  
end
