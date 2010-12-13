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

require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
