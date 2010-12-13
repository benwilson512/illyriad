# == Schema Information
#
# Table name: relationships
#
#  id          :integer(4)      not null, primary key
#  type        :string(255)
#  game_id     :integer(4)
#  established :datetime
#  proposer_id :integer(4)
#  acceptor_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Relationship < ActiveRecord::Base
  belongs_to :proposer, :class_name => "Alliance"
  belongs_to :accepter, :class_name => "Alliance"
end
