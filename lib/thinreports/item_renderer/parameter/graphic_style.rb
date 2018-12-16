# frozen_string_literal: true

module Thinreports
  module ItemRenderer
    module Parameter
      class GraphicStyle
        def initialize(pdf, item)
          @pdf = pdf
          @style = item.style.finalized_styles
        end

        def parameters
          {
            stroke: style['border-color'],
            stroke_width: style['border-width'],
            stroke_type: style['border-style'],
            fill: style['fill-color']
          }
        end

        private

        attr_reader :pdf, :style
      end
    end
  end
end
