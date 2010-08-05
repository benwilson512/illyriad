class Siege < ActiveRecord::Base
  
  belongs_to :target, :class_name => "Town"
  belongs_to :creator, :class_name => "User"
  has_many :siege_forces
  
  validates_uniqueness_of :name
  
  def direction_to_coordinates(direction)
    delta_x = 0
    delta_y = 0
    delta_y += 1 if direction.include?('N') 
    delta_y += -1 if direction.include?('S')
    delta_x += 1 if direction.include?('E')
    delta_x += -1 if direction.include?('W')
    puts direction
    coordinates = {:x => self.target.x + delta_x, :y => self.target.y + delta_y}
    puts coordinates.inspect
    coordinates
  end
  
  def position_coordinates
    coordinates = []
    self.positions.delete(' ').split(',').each do |direction|
      delta_x = 0
      delta_y = 0
      delta_y += 1 if direction.include?('N') 
      delta_y += -1 if direction.include?('S')
      delta_x += 1 if direction.include?('E')
      delta_x += -1 if direction.include?('W')
      coordinates << {:direction => direction, :x => (self.target.x + delta_x), :y => (self.target.y + delta_y)}
    end
    return coordinates
  end
  
end


# == Schema Information
#
# Table name: sieges
#
#  id                        :integer(4)      not null, primary key
#  name                      :string(255)
#  target_id                 :integer(4)
#  time                      :datetime
#  positions                 :string(255)
#  creator_id                :integer(4)
#  reinforce_time_delta      :integer(4)      default(0)
#  clearing_force_time_delta :integer(4)      default(0)
#  roles                     :string(255)
#  comments                  :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#

