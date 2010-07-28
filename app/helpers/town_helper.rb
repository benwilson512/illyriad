module TownHelper
  
  def select_role_in_siege(*roles)
    options = ""
    roles.each {|role| options << "<options>#{role}</options>"}
    puts options
    select_tag :role, options
  end
  
end
