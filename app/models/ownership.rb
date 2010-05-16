# == Schema Information
#
# Table name: ownerships
#
#  id         :integer(4)      not null, primary key
#  player_id  :integer(4)
#  town_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Ownership < ActiveRecord::Base
  
  belongs_to :player
  belongs_to :town
  
end

