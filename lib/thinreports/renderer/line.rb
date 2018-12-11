# frozen_string_literal: true

require_relative 'parameter/graphic_style'

module Thinreports
  module Renderer
    class Line
      def initialize(pdf, item)
        @pdf = pdf
        @item = item
        @schema = item.format
      end

      def render
        pdf.line(
          schema.attributes['x1'],
          schema.attributes['y1'],
          schema.attributes['x2'],
          schema.attributes['y2'],
          graphic_style_params
        )
      end

      private

      attr_reader :pdf, :item, :schema

      def graphic_style_params
        Parameter::GraphicStyle.new(pdf, item).parameters
      end
    end
  end
end
