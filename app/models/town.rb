class Town < ActiveRecord::Base
  
  # has_many :buildings
  has_one :ownership
  has_one :player, :through => :ownership
  
  validates_uniqueness_of :game_id
  
  named_scope :at_coordinates, lambda { |x,y| {:conditions => {:x => x, :y => y } } }
  named_scope :by_name, lambda { |name| {:conditions => { :name => name } } }
  named_scope :population_greater_than, lambda { |population| {:conditions => ["population >= #{population}"] } }
  named_scope :x_greater_than, lambda { |x_value| {:conditions => ["x >= #{x_value}"] } }
  named_scope :x_less_than, lambda { |x_value| {:conditions => ["x <= #{x_value}"] } }
  named_scope :y_greater_than, lambda { |y_value| {:conditions => ["y >= #{y_value}"] } }
  named_scope :y_less_than, lambda { |y_value| {:conditions => ["y <= #{y_value}"] } }
  
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
