class Player < ActiveRecord::Base
  
  has_many :ownerships
  has_many :towns, :through => :ownerships
  
  belongs_to :alliance
  
end
