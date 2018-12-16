# frozen_string_literal: true

module Thinreports
  module BasicReport
    module Renderer
      class Template < Base
        def render
          items.each do |item_attributes|
            next unless drawable?(item_attributes)

            item = build_item(item_attributes)

            case item_attributes['type']
            when 'text'
              ItemRenderer::Text.new(@pdf, item).render
            when 'image'
              ItemRenderer::Image.new(@pdf, item).render
            when 'rect'
              ItemRenderer::Rect.new(@pdf, item).render
            when 'ellipse'
              ItemRenderer::Ellipse.new(@pdf, item).render
            when 'line'
              ItemRenderer::Line.new(@pdf, item).render
            end
          end
        end

        private

        def items
          @format.attributes['items']
        end

        def build_item(item_attributes)
          schema = Core::Shape::Format(item_attributes['type']).new(item_attributes)
          Core::Shape::Interface(nil, schema).internal
        end

        def drawable?(item_attributes)
          item_attributes['id'].empty? && item_attributes['display']
        end
      end
    end
  end
end
