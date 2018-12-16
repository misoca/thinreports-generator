# frozen_string_literal: true

require_relative 'parameter/text_box'

module Thinreports
  module ItemRenderer
    class TextBlock
      def initialize(pdf, item)
        @pdf = pdf
        @item = item
      end

      def render
        return if content.empty?

        pdf.text_box(content, *params.values_at(:x, :y, :width, :height, :attrs))
      end

      private

      attr_reader :pdf, :item

      def params
        Parameter::TextBox.new(pdf, item).parameters(single: single)
      end

      def single
        !item.multiple?
      end

      def content
        @content ||=
          if item.multiple?
            item.real_value.to_s
          else
            item.real_value.to_s.tr("\n", ' ')
          end
      end
    end
  end
end
