module TownsHelper
  def select_role_in_siege(*roles)
    options = []
    roles.each {|role| options << [role, role.downcase.gsub(' ','_')] }
    return select_tag :role, options_for_select(options)
  end
  
  def select_siege_position(coordinates)
    options = []
    coordinates.each {|coordinate| options << ["#{coordinate[:direction]}: #{coordinate[:x]},#{coordinate[:y]}", "#{coordinate[:direction]},#{coordinate[:x]},#{coordinate[:y]}"]}
    return select_tag :destination, options_for_select(options)
  end
end
