# frozen_string_literal: true

module Thinreports
  module SimpleReport
    module Pdf
      module DrawTemplateItems
        # @param [Array<Hash>] items
        def draw_template_items(items)
          items.each do |item_attributes|
            next unless drawable?(item_attributes)

            item = build_item_internal(item_attributes['type'], item_attributes)

            case item_attributes['type']
            when 'text' then draw_shape_text(item)
            when 'image' then draw_shape_image(item)
            when 'rect' then draw_shape_rect(item)
            when 'ellipse' then draw_shape_ellipse(item)
            when 'line' then draw_shape_line(item)
            end
          end
        end

        private

        def build_item_internal(type, attributes)
          schema = Core::Shape::Format(type).new(attributes)
          Core::Shape::Interface(nil, schema).internal
        end

        def drawable?(item_attributes)
          item_attributes['id'].empty? && item_attributes['display']
        end
      end
    end
  end
end
