require 'rails/generators'
require_relative 'rspec/form_object_generator'
require_relative 'test_generator'
require_relative 'test_unit/form_object_generator'
require_relative 'mini_test/form_object_generator'

module ActiveModel
  module Generators
    class FormObjectGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      argument :name,
        :type => :string,
        :banner => "resource"

      argument :operation,
        :type => :string,
        :default => "create",
        :banner => "operation"

      class_option :parent,
        :type => :string,
        :desc => 'The parent class for the generated form_object'

      hook_for :test_framework

      class_option :spec,
        :type => :boolean,
        :default => false,
        :desc => "If using MiniTest, use MiniTest::Spec DSL"

      def create_form_object
        template 'form_object.rb', File.join('app/form_objects', class_path, "#{file_name}_#{operation}.rb")
      end

      def show_readme
        readme "README"
      end

      protected

      def klass_name
        "#{class_name}#{operation.camelize}"
      end

      def has_parent_class?
        options.has_key?("parent")
      end

      def parent_class_name
        if has_parent_class?
          options[:parent]
        end
      end
    end
  end
end
