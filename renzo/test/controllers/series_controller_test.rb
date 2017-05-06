require 'test_helper'

class SeriesControllerTest < ActionDispatch::IntegrationTest

    def setup
      @serie = microposts(:orange)
    end

    test "should redirect create when not logged in" do
      assert_no_difference 'Serie.count' do
        post series_path, params: { serie: { content: "Mr Robot" } }
      end
      assert_redirected_to login_url
    end

    test "should redirect destroy when not logged in" do
      assert_no_difference 'Serie.count' do
        delete serie_path(@serie)
      end
      assert_redirected_to login_url
    end

    test "should redirect destroy for wrong serie" do
      log_in_as(users(:italo))
      serie = (:ants)
      assert_no_difference 'Serie.count' do
        delete serie_path(serie)
      end
      assert_redirected_to root_url
    end
end
