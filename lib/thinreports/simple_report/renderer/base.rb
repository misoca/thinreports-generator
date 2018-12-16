# frozen_string_literal: true

module Thinreports
  module SimpleReport
    module Renderer
      # @abstract
      class Base
        # @param [Thinreports::SimpleReport::Pdf::Document] pdf
        # @param [Thinreports::Core::Shape::Manager::Format] format
        def initialize(pdf, format)
          @pdf = pdf
          @format = format
        end

        # @abstract
        def render
          raise NotImplementedError
        end

        private

        # Create stamp if not exist
        #
        # @param [String] stamp_id
        # @return [String] stamp_id
        def create_stamp(stamp_id, &block)
          unless @pdf.stamp_exist?(stamp_id)
            @pdf.create_stamp(stamp_id, &block)
          end
          stamp_id
        end

        # @param [Thinreports::Core::Shape::Base::Internal] shape
        # @return [String]
        def build_item_stamp_id(shape)
          "#{@format.identifier}#{shape.identifier}"
        end

        # @param [Thinreports::Core::Shape::Base::Internal] shape
        def create_item_stamp(shape, &block)
          create_stamp(build_item_stamp_id(shape), &block)
        end
      end
    end
  end
end
