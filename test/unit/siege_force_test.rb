require 'test_helper'

class SiegeForceTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end




# == Schema Information
#
# Table name: siege_forces
#
#  id            :integer(4)      not null, primary key
#  siege_id      :integer(4)
#  town_id       :integer(4)
#  destination_x :integer(4)
#  destination_y :integer(4)
#  destination   :string(255)
#  troops        :integer(4)
#  role          :string(255)
#  speed         :string(255)
#  comments      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

