# frozen_string_literal: true

require 'thinreports/renderer/text_block'
require 'thinreports/renderer/image'
require 'thinreports/renderer/page_number'
require 'thinreports/renderer/image_block'
require 'thinreports/renderer/text'
require 'thinreports/renderer/ellipse'
require 'thinreports/renderer/line'
require 'thinreports/renderer/rect'

module Thinreports
  module SimpleReport
    module Pdf
      module DrawShape
        # @param [Thinreports::Core::Shape::TextBlock::Internal] shape
        def draw_shape_tblock(shape)
          Thinreports::Renderer::TextBlock.new(self, shape).render
        end

        def draw_shape_pageno(shape, page_no, page_count)
          Thinreports::Renderer::PageNumber.new(self, shape).render(no: page_no, count: page_count)
        end

        # @param [Thinreports::Core::Shape::Basic::Internal] shape
        def draw_shape_image(shape)
          Thinreports::Renderer::Image.new(self, shape).render
        end

        # @param [Thinreports::Core::Shape::ImageBlock::Internal] shape
        def draw_shape_iblock(shape)
          Thinreports::Renderer::ImageBlock.new(self, shape).render
        end

        # @param [Thinreports::Core::Shape::Text::Internal] shape
        def draw_shape_text(shape)
          Thinreports::Renderer::Text.new(self, shape).render
        end

        # @param [Thinreports::Core::Shape::Basic::Internal] shape
        def draw_shape_ellipse(shape)
          Thinreports::Renderer::Ellipse.new(self, shape).render
        end

        # @param [Thinreports::Core::Shape::Basic::Internal] shape
        def draw_shape_line(shape)
          Thinreports::Renderer::Line.new(self, shape).render
        end

        # @param [Thinreports::Core::Shape::Basic::Internal] shape
        def draw_shape_rect(shape)
          Thinreports::Renderer::Rect.new(self, shape).render
        end
      end
    end
  end
end
