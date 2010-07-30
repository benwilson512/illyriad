# == Schema Information
#
# Table name: towns
#
#  id               :integer(4)      not null, primary key
#  name             :string(255)
#  x                :integer(4)
#  y                :integer(4)
#  population       :integer(4)
#  capital          :boolean(1)
#  alliance_capital :boolean(1)
#  game_id          :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#  player_id        :integer(4)
#

class Town < ActiveRecord::Base
  
  # has_many :buildings
  belongs_to :player
  has_many :nearest_calculations
  has_many :sieges
  has_many :siege_forces
  
  validates_uniqueness_of :game_id
  
  scope :at_coordinates, lambda { |x,y| {:conditions => {:x => x, :y => y } } }
  scope :by_name, lambda { |name| {:conditions => { :name => name } } }
  scope :population_greater_than, lambda { |population| {:conditions => ["population >= #{population}"] } }
  scope :x_greater_than, lambda { |x_value| {:conditions => ["x >= #{x_value}"] } }
  scope :x_less_than, lambda { |x_value| {:conditions => ["x <= #{x_value}"] } }
  scope :y_greater_than, lambda { |y_value| {:conditions => ["y >= #{y_value}"] } }
  scope :y_less_than, lambda { |y_value| {:conditions => ["y <= #{y_value}"] } }
  scope :within_square_area, lambda { |town,distance| {:conditions => ["((x >= #{town.x-distance}) AND (x <= #{town.x+distance}) AND (y >= #{town.y-distance}) AND (y <= #{town.y+distance}))"] } }
  scope :owned_by, lambda { |player_id| {:conditions => {:player_id => player_id } } }
  
  def alliance
    self.player.alliance
  end
  
  def find_reinforcements(params)
    reinforcements = []
    speed = params[:speed].to_i
    max_time = params[:time].to_i
    max_distance = speed * max_time
    Town.within_square_area(self,max_distance).each do |town|
      distance = distance_from(town.x, town.y)
      time = distance / speed
      if time < max_time && town != self && town.player.alliance == self.player.alliance
        reinforcements << {:distance => distance, :time => time, :town => town}
      end
    end
    
    sorted = reinforcements.sort_by { |item| item[:time] }
  end
  
  def distance_from(test_x,test_y)
    Math.sqrt((self.x-test_x)**2 + (self.y-test_y)**2)
  end
  
  def location
    [self.x, self.y]
  end
  
end
