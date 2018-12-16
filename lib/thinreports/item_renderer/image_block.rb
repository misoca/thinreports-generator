# frozen_string_literal: true

require_relative 'parameter/image_box'

module Thinreports
  module ItemRenderer
    class ImageBlock
      include Thinreports::Utils

      def initialize(pdf, item)
        @pdf = pdf
        @item = item
      end

      def render
        return if blank_value?(item.src)

        pdf.image_box(item.src, *params.values_at(:x, :y, :width, :height, :attrs))
      end

      private

      attr_reader :pdf, :item

      def params
        Parameter::ImageBox.new(pdf, item).parameters
      end
    end
  end
end
