# frozen_string_literal: true

require_relative 'parameter/graphic_style'

module Thinreports
  module ItemRenderer
    class Rect
      def initialize(pdf, item)
        @pdf = pdf
        @item = item
        @schema = item.format
      end

      def render
        pdf.rect(
          schema.attributes['x'],
          schema.attributes['y'],
          schema.attributes['width'],
          schema.attributes['height'],
          graphic_style_params.merge(
            radius: schema.attributes['border-radius']
          )
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
