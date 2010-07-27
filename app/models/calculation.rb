# == Schema Information
#
# Table name: calculations
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  type        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Calculation < ActiveRecord::Base
  
end

