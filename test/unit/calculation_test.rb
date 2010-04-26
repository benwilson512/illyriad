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

require 'test_helper'

class CalculationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

