require 'test_helper'

class SiegeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: sieges
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  target_id  :integer(4)
#  time       :datetime
#  positions  :string(255)
#  creator_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

