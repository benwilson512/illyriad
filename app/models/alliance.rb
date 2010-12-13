# == Schema Information
#
# Table name: alliances
#
#  id               :integer(4)      not null, primary key
#  game_id          :integer(4)
#  name             :string(255)
#  ticker           :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  founder_id       :integer(4)
#  capital_id       :integer(4)
#  founded          :datetime
#  tax_rate         :float
#  set_tax_date     :datetime
#  total_population :integer(4)
#

class Alliance < ActiveRecord::Base
  
  has_many :players
  
  validates_uniqueness_of :game_id
  
  scope :by_name, :order => :name
  
end
