# == Schema Information
#
# Table name: ownerships
#
#  id         :integer(4)      not null, primary key
#  player_id  :integer(4)
#  town_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class OwnershipTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

