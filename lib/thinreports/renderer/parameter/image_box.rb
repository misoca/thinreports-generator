# frozen_string_literal: true

module Thinreports
  module Renderer
    module Parameter
      class ImageBox
        def initialize(pdf, item)
          @pdf = pdf
          @item = item
          @schema = item.format
          @style = item.style.finalized_styles
        end

        def parameters
          {
            x: schema.attributes['x'],
            y: schema.attributes['y'],
            width: schema.attributes['width'],
            height: schema.attributes['height'],
            attrs: {
              position_x: image_position_x(style['position-x']),
              position_y: image_position_y(style['position-y'])
            }
          }
        end

        private

        attr_reader :pdf, :item, :schema, :style

        # @param ["left", "center", "right", ""] position
        # @return [:left, :center, :right]
        def image_position_x(position)
          case position
          when 'left' then :left
          when 'center' then :center
          when 'right' then :right
          when '' then :left
          else :left
          end
        end

        # @param ["top", "middle", "bottom", ""] position
        # @return [:left, :center, :right]
        def image_position_y(position)
          case position
          when 'top' then :top
          when 'middle' then :center
          when 'bottom' then :bottom
          when '' then :top
          else :top
          end
        end
      end
    end
  end
end
