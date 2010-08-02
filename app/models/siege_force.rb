class SiegeForce < ActiveRecord::Base
  
  belongs_to :siege
  belongs_to :town
  
  scope :for_siege, lambda {|siege_id| {:conditions => {:siege_id => siege_id } } }
  scope :with_role, lambda {|role| {:conditions => {:role => role } } }
  scope :with_destination, lambda {|dest| {:conditions => {:destination => dest } } }
  # scope :closest_first, :order_by => :travel_time
  
  def departure_time(arrival_time)
    departure_time = arrival_time - travel_time.hours
  end
  
  def travel_time
    self.town.distance_from(self.destination_x,self.destination_y)/self.speed.to_f
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
#  comments      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

