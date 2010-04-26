# == Schema Information
#
# Table name: alliances
#
#  id         :integer(4)      not null, primary key
#  game_id    :integer(4)
#  name       :string(255)
#  ticker     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class AllianceTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

