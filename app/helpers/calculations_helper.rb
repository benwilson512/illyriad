module CalculationsHelper
  
  def format_time(number)
    string_num = number.to_s.split(".")
    hours = string_num[0]
    minutes = (string_num[1][0...2].to_f / 100) * 60
    return "#{hours} hours, #{minutes} minutes"
  end
  
  def format_siege_time(distance)
    number = distance / 4
    string_num = number.to_s.split(".")
    hours = string_num[0]
    minutes = (string_num[1][0...2].to_f / 100) * 60
    return "#{hours} hours, #{minutes} minutes"
  end
end
