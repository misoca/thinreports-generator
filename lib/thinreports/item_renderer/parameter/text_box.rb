# frozen_string_literal: true

require_relative 'text_style'

module Thinreports
  module ItemRenderer
    module Parameter
      class TextBox
        def initialize(pdf, item)
          @pdf = pdf
          @item = item
          @schema = item.format
        end

        def parameters(single: false)
          {
            x: schema.attributes['x'],
            y: schema.attributes['y'],
            width: schema.attributes['width'],
            height: schema.attributes['height'],
            attrs: {
              single: single,
            }.merge(text_style_params)
          }
        end

        private

        attr_reader :pdf, :item, :schema

        def text_style_params
          Parameter::TextStyle.new(pdf, item).parameters
        end
      end
    end
  end
end
