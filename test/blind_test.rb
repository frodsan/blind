require 'minitest/autorun'
require 'action_controller'
require File.expand_path('../lib/blind', File.dirname(__FILE__))

SharedTestRoutes = ActionDispatch::Routing::RouteSet.new

module ActionController
  class Base
    include SharedTestRoutes.url_helpers
  end

  class TestCase
    def setup
      @routes = SharedTestRoutes

      @routes.draw do
        get ':controller(/:action)'
      end
    end
  end
end

class BlindController < ActionController::Base
  abstract!

  def index
    render text: 'content'
  end
end

class BlindControllerTest < ActionController::TestCase
  def test_empty_view
    get :index

    assert_equal '', response.body
  end
end
