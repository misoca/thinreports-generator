# frozen_string_literal: true

require_relative 'parameter/text_box'

module Thinreports
  module Renderer
    class TextBlock
      def initialize(item, pdf)
        @item = item
        @pdf = pdf
      end

      def render
        return if params[:content].empty?

        pdf.text_box(*params.values_at(:content, :x, :y, :width, :height, :attrs))
      end

      private

      attr_reader :pdf, :item

      def params
        @params ||= Parameter::TextBox.new(pdf, item).parameters
      end
    end
  end
end
