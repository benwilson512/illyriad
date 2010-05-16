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
  
  def get_bbcode(report_items)
    code = "[table][tr][th]Town[/th][th]Player[/th][th]Population[/th][th]time[/th][th]siege time[/th][/tr]"
    report_items.each do |report_item|
      code << "[tr]"
      code << "[td]#{report_item[:town].name}[/td]"
      code << "[td]#{report_item[:town].player.name}[/td]"
      code << "[td]#{report_item[:town].population}[/td]"
      code << "[td]#{format_time report_item[:time]}[/td]"
      code << "[td]#{format_siege_time report_item[:distance]}[/td]"
      code << "[/tr]"
    end
    code << "[/table]"
    puts code
  end
  
end
