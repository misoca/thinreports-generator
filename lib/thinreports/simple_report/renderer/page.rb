# frozen_string_literal: true

module Thinreports
  module SimpleReport
    module Renderer
      class Page < Base
        # @param (see Renderer::Base#initialize)
        def initialize(pdf, format)
          super
          @lists = {}
        end

        # @param [Thinreports::SimpleReport::Report::Page] page
        def render(page)
          manager = page.manager

          manager.format.shapes.each_key do |id|
            shape = manager.final_shape(id)
            next unless shape

            shape = shape.internal

            if shape.type_of?(Core::Shape::PageNumber::TYPE_NAME)
              draw_pageno_shape(shape, page) if page.count? && shape.for_report?
            else
              draw_shape(shape)
            end
          end
        end

        private

        def draw_shape(shape)
          if shape.type_of?(Core::Shape::TextBlock::TYPE_NAME)
            draw_tblock_shape(shape)
          elsif shape.type_of?(Core::Shape::List::TYPE_NAME)
            draw_list_shape(shape)
          elsif shape.type_of?(Core::Shape::ImageBlock::TYPE_NAME)
            draw_iblock_shape(shape)
          else
            id = shape.identifier
            unless @stamps.include?(id)
              create_basic_shape_stamp(shape)
              @stamps << id
            end
            pdf_stamp(shape)
          end
        end

        def draw_pageno_shape(shape, page)
          @pdf.draw_shape_pageno(shape, page.no, page.report.page_count)
        end

        # @see #draw_shape
        def draw_list_shape(shape)
          list_renderer = @lists[shape.id] ||= Renderer::List.new(@pdf, shape.format)
          list_renderer.render(shape)
        end

        # @see #draw_shape
        def draw_tblock_shape(shape)
          @pdf.draw_shape_tblock(shape)
        end

        # @see #draw_shape
        def draw_iblock_shape(shape)
          @pdf.draw_shape_iblock(shape)
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
          create_pdf_stamp(shape) do
            @pdf.draw_shape_image(shape)
          end
        end

        # @see #create_basic_shape_stamp
        def create_rect_stamp(shape)
          create_pdf_stamp(shape) do
            @pdf.draw_shape_rect(shape)
          end
        end

        # @see #create_basic_shape_stamp
        def create_ellipse_stamp(shape)
          create_pdf_stamp(shape) do
            @pdf.draw_shape_ellipse(shape)
          end
        end

        # @see #create_basic_shape_stamp
        def create_line_stamp(shape)
          create_pdf_stamp(shape) do
            @pdf.draw_shape_line(shape)
          end
        end

        # @see #create_basic_shape_stamp
        def create_text_stamp(shape)
          create_pdf_stamp(shape) do
            @pdf.draw_shape_text(shape)
          end
        end
      end
    end
  end
end
