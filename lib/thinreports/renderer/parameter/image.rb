# frozen_string_literal: true

module Thinreports
  module Renderer
    module Parameter
      class Image
        def initialize(pdf, image)
          @pdf = pdf
          @item = image
          @schema = image.format
        end

        def parameters
          {
            image_data: image_data,
            x: schema.attributes['x'],
            y: schema.attributes['y'],
            width: schema.attributes['width'],
            height: schema.attributes['height']
          }
        end

        private

        attr_reader :pdf, :item, :schema

        def image_data
          schema.attributes['data']['base64']
        end
      end
    end
  end
end
