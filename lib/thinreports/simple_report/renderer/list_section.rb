# frozen_string_literal: true

module Thinreports
  module SimpleReport
    module Renderer
      class ListSection < Page
        # @param pdf (see Renderer::Page#initialize)
        # @param section [Thinreports::Core::Shape::List::SectionInternal] section
        def initialize(pdf, section)
          super(pdf, section.format)
          @section = section
          @stamp_created = false
        end

        # @param [Thinreports::Core::Shape::List::SectionInternal] section
        # @param [Array<Numeric>] at
        def render(section, at)
          @render_at = at
          draw_section
          super(section)
        end

        private

        def draw_section
          id = @format.identifier.to_s

          unless @stamp_created
            @pdf.create_stamp(id) { @pdf.draw_template_items(@format.attributes['items']) }
            @stamp_created = true
          end
          pdf_stamp(id)
        end

        # @see Thinreports::Pdf::Renderer::Page#draw_tblock_shape
        def draw_tblock_shape(shape)
          @pdf.translate(*@render_at) { super }
        end

        # @see Thinreports::Pdf::Renderer::Page#draw_iblock_shape
        def draw_iblock_shape(shape)
          @pdf.translate(*@render_at) { super }
        end
      end
    end
  end
end
