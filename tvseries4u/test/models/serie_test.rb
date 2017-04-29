require 'test_helper'

class SerieTest < ActiveSupport::TestCase

  def setup
    @user = users(:italo)
    @serie = @user.series.build(nombre: "Mr Robot")
  end

  test "should be valid" do
    assert @serie.valid?
  end

  test "user id should be present" do
    @serie.user_id = nil
    assert_not @serie.valid?
  end
end
