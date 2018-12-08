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
          @stamps = []
          @render_at = nil
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

        # @overload pdf_stamp(shape_id)
        #   @param [String] shape_id
        # @overload pdf_stamp(shape)
        #   @param [Thinreports::Core::Shape::Base::Internal] shape
        def pdf_stamp(shape)
          shape = pdf_stamp_id(shape) unless shape.is_a?(::String)
          @pdf.stamp(shape, @render_at)
        end

        # @param [Thinreports::Core::Shape::Base::Internal] shape
        def create_pdf_stamp(shape, &block)
          @pdf.create_stamp(pdf_stamp_id(shape), &block)
        end
      end
    end
  end
end
