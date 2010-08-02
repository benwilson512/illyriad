module SiegesHelper
  def active_siege_or_not(siege)
    if siege == session[:siege]
      "Active"
    else
      link_to "Activate!", activate_siege_path(siege)
    end
  end
  
  def select_siege_position(coordinates)
    options = []
    coordinates.each {|coordinate| options << ["#{coordinate[:direction]}: #{coordinate[:x]},#{coordinate[:y]}", "#{coordinate[:direction]},#{coordinate[:x]},#{coordinate[:y]}"]}
    return select_tag :destination, options_for_select(options)
  end
end
