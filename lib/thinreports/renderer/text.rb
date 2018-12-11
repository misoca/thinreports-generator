# frozen_string_literal: true

require_relative 'parameter/text'

module Thinreports
  module Renderer
    class Text
      def initialize(pdf, item)
        @pdf = pdf
        @item = item
      end

      def render
        pdf.text(texts, *params.values_at(:x, :y, :width, :height, :attrs))
      end

      private

      attr_reader :pdf, :item

      def params
        Parameter::Text.new(pdf, item).parameters
      end

      def texts
        item.texts.join("\n")
      end
    end
  end
end
