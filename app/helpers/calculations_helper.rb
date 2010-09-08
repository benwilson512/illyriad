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
  
  def get_bbcode(report_items, *speed)
    code = "[table][tr][th]Town[/th][th]Player[/th][th]Population[/th][th]Time (#{speed})[/th][th]Siege time[/th][/tr]"
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
  end
  
  def get_html(report_items, *speed)
    code = "<h1>Target</h1><h2>#{@town.name}</h2><p>Population #{@town.population} </p><p>#{@report_items.size} valid results for town: <b>#{@town.name}</b></p>"
    code << "<table>
        <tr>
          <th>Town Name</th>
          <th>Town Owner</th>
          <th>Population</th>
          <th>Alliance</th>
          <th>Time (speed #{speed})</th>
          <th>Siege Time</th>
        </tr>"
    @report_items.each do |report_item|
    code << "<tr>
          <td>#{link_to report_item[:town].name, town_path(report_item[:town])}</td>
          <td>#{link_to report_item[:town].player.name, player_path(report_item[:town].player)}</td>
          <td>#{report_item[:town].population}</td>
          <td>#{link_to_alliance(report_item[:town].player)}</td>
          <td>#{format_time(report_item[:time])}</td>
          <td>#{format_siege_time report_item[:distance]}</td>
    	  <td>#{link_to "view", "http://uk1.illyriad.co.uk/view_map.asp?Radius=5&CenterX=#{report_item[:town].x}&CenterY=#{report_item[:town].y}"}</td>
        </tr>"
        end
    code << "</table>"
  end
  
end
