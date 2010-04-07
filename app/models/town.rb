class Town < ActiveRecord::Base
  
  # has_many :buildings
  has_one :ownership
  has_one :player, :through => :ownership, :as => :owner
  
  def set_location!(new_x,new_y)
    self.x = x if new_x
    self.y = y if new_y
    self.save
  end
  
  def distance_from(test_x,test_y)
    Math.sqrt((self.x-test_x).power!(2) + (self.y-test_y).power!(2))
  end
  
  def location
    [self.x,self.y]
  end
  
end
