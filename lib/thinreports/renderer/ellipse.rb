# frozen_string_literal: true

require_relative 'parameter/graphic_style'

module Thinreports
  module Renderer
    class Ellipse
      def initialize(pdf, item)
        @pdf = pdf
        @item = item
        @schema = item.format
      end

      def render
        pdf.ellipse(
          schema.attributes['cx'],
          schema.attributes['cy'],
          schema.attributes['rx'],
          schema.attributes['ry'],
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
