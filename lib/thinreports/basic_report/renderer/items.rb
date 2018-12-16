# frozen_string_literal: true

module Thinreports
  module BasicReport
    module Renderer
      class Items < Base
        def initialize(pdf, format)
          super
          @list_renderers = {}
        end

        # @param [Thinreports::Core::Shape::Manager::Target] page_or_section
        # @param [Array<Numeric>] translate_at
        def render(page_or_section, translate_at = nil)
          item_manager = page_or_section.manager
          schema_items = item_manager.format.shapes

          schema_items.each_key do |id|
            item = item_manager.final_shape(id)
            next unless item

            item = item.internal

            if item.type_of?(Core::Shape::PageNumber::TYPE_NAME)
              draw_pageno_shape(item, page_or_section)
            else
              draw_shape(item, translate_at)
            end
          end
        end

        private

        def draw_shape(shape, translate_at = nil)
          if shape.type_of?(Core::Shape::TextBlock::TYPE_NAME)
            draw_tblock_shape(shape, translate_at)
          elsif shape.type_of?(Core::Shape::List::TYPE_NAME)
            draw_list_shape(shape)
          elsif shape.type_of?(Core::Shape::ImageBlock::TYPE_NAME)
            draw_iblock_shape(shape, translate_at)
          else
            item_stamp_id = create_basic_shape_stamp(shape)
            @pdf.stamp(item_stamp_id, translate_at)
          end
        end

        def draw_pageno_shape(shape, page_or_section)
          return unless page_or_section.is_a?(Report::Page)

          page = page_or_section

          if page.count? && shape.for_report?
            Thinreports::Renderer::PageNumber.new(@pdf, shape)
              .render(
                no: page.no,
                count: page.report.page_count
              )
          end
        end

        # @see #draw_shape
        def draw_list_shape(shape)
          list_renderer = @list_renderers[shape.id] ||= Renderer::List.new(@pdf, shape.format)
          list_renderer.render(shape)
        end

        # @see #draw_shape
        def draw_tblock_shape(shape, translate_at = nil)
          renderer = Thinreports::Renderer::TextBlock.new(@pdf, shape)
          if translate_at
            @pdf.translate(*translate_at) { renderer.render }
          else
            renderer.render
          end
        end

        # @see #draw_shape
        def draw_iblock_shape(shape, translate_at = nil)
          renderer = Thinreports::Renderer::ImageBlock.new(@pdf, shape)
          if translate_at
            @pdf.translate(*translate_at) { renderer.render }
          else
            renderer.render
          end
        end

        # @param [Thinreports::Core::Shape::Base::Internal] shape
        def create_basic_shape_stamp(shape)
          if shape.type_of?('text')
            create_text_stamp(shape)
          elsif shape.type_of?('image')
            create_image_stamp(shape)
          elsif shape.type_of?('ellipse')
            create_ellipse_stamp(shape)
          elsif shape.type_of?('rect')
            create_rect_stamp(shape)
          elsif shape.type_of?('line')
            create_line_stamp(shape)
          end
        end

        # @see #create_basic_shape_stamp
        def create_image_stamp(shape)
          create_item_stamp(shape) do
            Thinreports::Renderer::Image.new(@pdf, shape).render
          end
        end

        # @see #create_basic_shape_stamp
        def create_rect_stamp(shape)
          create_item_stamp(shape) do
            Thinreports::Renderer::Rect.new(@pdf, shape).render
          end
        end

        # @see #create_basic_shape_stamp
        def create_ellipse_stamp(shape)
          create_item_stamp(shape) do
            Thinreports::Renderer::Ellipse.new(@pdf, shape).render
          end
        end

        # @see #create_basic_shape_stamp
        def create_line_stamp(shape)
          create_item_stamp(shape) do
            Thinreports::Renderer::Line.new(@pdf, shape).render
          end
        end

        # @see #create_basic_shape_stamp
        def create_text_stamp(shape)
          create_item_stamp(shape) do
            Thinreports::Renderer::Text.new(@pdf, shape).render
          end
        end
      end
    end
  end
end
