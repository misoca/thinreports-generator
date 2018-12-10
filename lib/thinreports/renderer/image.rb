# frozen_string_literal: true

require_relative 'parameter/image'

module Thinreports
  module Renderer
    class Image
      def initialize(pdf, item)
        @pdf = pdf
        @item = item
      end

      def render
        pdf.base64image(*params.values_at(:image_data, :x, :y, :width, :height))
      end

      private

      attr_reader :pdf, :item

      def params
        Parameter::Image.new(pdf, item).parameters
      end
    end
  end
end
