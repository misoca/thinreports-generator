# frozen_string_literal: true

require_relative 'parameter/text_box'

module Thinreports
  module Renderer
    class PageNumber
      def initialize(pdf, item)
        @pdf = pdf
        @item = item
      end

      def render(no:, count:)
        content = build_content(no, count)

        pdf.text_box(content, *params.values_at(:x, :y, :width, :height, :attrs))
      end

      private

      attr_reader :pdf, :item

      def params
        @params ||= Parameter::TextBox.new(pdf, item).parameters
      end

      def build_content(no, count)
        item.build_format(no, count)
      end
    end
  end
end
