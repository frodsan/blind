require 'active_support/concern'
require 'active_support/core_ext/class/attribute'

module Blind
  extend ActiveSupport::Concern

  attr_accessor :controller

  included do
    class_attribute :render_views
    self.render_views = false

    setup do
      if !render_views
        @_empty_view_path_set_delegator = EmptyTemplatePathSetDecorator.new controller.class.view_paths
        controller.class.view_paths = ::ActionView::PathSet.new.push @_empty_view_path_set_delegator
        controller.extend EmptyTemplates
      end
    end

    teardown do
      if !render_views
        controller.class.view_paths = @_empty_view_path_set_delegator.original_path_set
      end
    end
  end

  module ClassMethods
    def render_views!
      self.render_views = true
    end
  end

private

  class EmptyTemplatePathSetDecorator < ::ActionView::Resolver
    attr_reader :original_path_set

    def initialize original_path_set
      @original_path_set = original_path_set
    end

    def find_all *args
      original_path_set.find_all(*args).collect do |template|
        ::ActionView::Template.new(
          '',
          template.identifier,
          template.handler,
          {
            virtual_path: template.virtual_path,
            format: template.formats
          }
        )
      end
    end
  end

  module EmptyTemplates
    def prepend_view_path new_path
      lookup_context.view_paths.unshift(*_path_decorator(new_path))
    end

    def append_view_path new_path
      lookup_context.view_paths.push(*_path_decorator(new_path))
    end

    private

    def _path_decorator path
      EmptyTemplatePathSetDecorator.new(ActionView::PathSet.new(Array.wrap(path)))
    end
  end
end
