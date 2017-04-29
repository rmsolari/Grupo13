require 'test_helper'

class SeriesInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:italo)
  end

  test "serie interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Serie.count' do
      post series_path, params: { serie: { nombre: "" } }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "This serie really ties the room together"
    assert_difference 'Serie.count', 1 do
      post series_path, params: { serie: { nombre: nombre } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete post
    assert_select 'a', text: 'delete'
    first_serie = @user.series.paginate(page: 1).first
    assert_difference 'Serie.count', -1 do
      delete serie_path(first_serie)
    end
    # Visit different user (no delete links)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end

  test "serie sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{FILL_IN} series", response.body
    # User with zero microposts
    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match "0 series", response.body
    other_user.series.create!(content: "A serie")
    get root_path
    assert_match FILL_IN, response.body
  end
end
