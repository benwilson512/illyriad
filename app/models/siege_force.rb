class SiegeForce < ActiveRecord::Base
  
  belongs_to :siege
  belongs_to :town
  
  scope :for_siege, lambda {|siege_id| {:conditions => {:siege_id => siege_id } } }
  scope :with_role, lambda {|role| {:conditions => {:role => role } } }
  scope :with_destination, lambda {|dest| {:conditions => {:destination => dest } } }
  # scope :closest_first, :order_by => :travel_time
  
  def departure_time
    
  end
end

# == Schema Information
#
# Table name: siege_forces
#
#  id            :integer(4)      not null, primary key
#  siege_id      :integer(4)
#  town_id       :integer(4)
#  destination_x :integer(4)
#  destination_y :integer(4)
#  destination   :string(255)
#  troops        :integer(4)
#  role          :string(255)
#  speed         :string(255)
#  arrival_time  :datetime
#  comments      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

