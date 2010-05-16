# == Schema Information
#
# Table name: players
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  game_id     :integer(4)
#  race        :string(255)
#  alliance_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

