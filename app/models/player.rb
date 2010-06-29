# == Schema Information
#
# Table name: players
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  game_id     :integer(4)
#  race        :string(255)
#  alliance_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Player < ActiveRecord::Base
  
  has_many :towns
  
  belongs_to :alliance
  scope :by_name, :order => :name
  scope :of_race, lambda { |race| {:conditions => { :race => race } } }
  
end
