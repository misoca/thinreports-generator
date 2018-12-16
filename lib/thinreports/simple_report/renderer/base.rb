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

        # @param [Thinreports::Core::Shape::Base::Internal] shape
        # @return [String]
        def pdf_stamp_id(shape)
          "#{@format.identifier}#{shape.identifier}"
        end

        # Create stamp if not exist
        #
        # @param [String] stamp_id
        def create_stamp(stamp_id, &block)
          return if @pdf.stamp_exist?(stamp_id)
          @pdf.create_stamp(stamp_id, &block)
        end

        # @param [Thinreports::Core::Shape::Base::Internal] shape
        def create_item_stamp(shape, &block)
          create_stamp(pdf_stamp_id(shape), &block)
        end
      end
    end
  end
end
