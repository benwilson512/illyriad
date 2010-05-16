class MapController < ApplicationController
  
  caches_action :index
  
  def index
    gv = Google::Visualization
    @coordinates = Town.all.collect { |town| [town.x, town.y, town] }
    @data_table = gv::DataTable.new
    @data_table.add_column gv::DataColumn.new(gv::DataType::NUMBER)
    @data_table.add_column gv::DataColumn.new(gv::DataType::NUMBER)
    @data_table.add_column gv::DataColumn.new(gv::DataType::STRING)
    Town.all.each do |town|
      @data_table.add_row [town.x, town.y, town.player.alliance ? town.player.alliance.name : "Unaffiliated" ]
    end
  end
end
