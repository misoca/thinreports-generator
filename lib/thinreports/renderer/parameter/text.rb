# frozen_string_literal: true

module Thinreports
  module Renderer
    module Parameter
      class Text
        def initialize(pdf, item)
          @pdf = pdf
          @item = item
          @schema = item.format
        end

        def parameters
          {
            x: schema.attributes['x'],
            y: schema.attributes['y'],
            width: schema.attributes['width'],
            height: schema.attributes['height'],
            attrs: text_style_params
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
