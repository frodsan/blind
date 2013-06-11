require 'minitest/autorun'
require 'action_controller'
require File.expand_path('../lib/blind', File.dirname(__FILE__))

SharedTestRoutes = ActionDispatch::Routing::RouteSet.new

module ActionController
  class Base
    include SharedTestRoutes.url_helpers

    self.view_paths = File.join File.dirname(__FILE__), 'views'
  end

  class TestCase
    include Blind

    setup do
      @routes = SharedTestRoutes

      @routes.draw do
        get ':controller(/:action)'
      end
    end

    def self.test_order
      :random
    end
  end
end

class BlindController < ActionController::Base
  abstract!

  def index
    render
  end
end

class BlindControllerTest < ActionController::TestCase
  def test_empty_view
    get :index

    assert response.body.empty?
    assert_template 'index'
  end
end

class UnBlindControllerTest < ActionController::TestCase
  tests BlindController

  render_views!

  def test_renders_view
    get :index

    assert !response.body.empty?
    assert_template 'index'
  end
end
