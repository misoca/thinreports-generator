# frozen_string_literal: true

require_relative 'items'
require_relative 'template'

module Thinreports
  module BasicReport
    module Renderer
      class ListSection < Base
        # @param [Thinreports::Core::Shape::List::SectionInterface] section
        # @param [Array<Numeric>] position
        def render(section, position)
          render_template(section.internal.format, position)
          render_items(section, position)
        end

        private

        attr_reader :section

        def render_template(section_format, translate_at)
          format_id = "section-#{section_format.identifier}"

          create_stamp(format_id) do
            Renderer::Template.new(@pdf, section_format).render
          end

          @pdf.stamp(format_id, translate_at)
        end

        def render_items(section, translate_at)
          Renderer::Items.new(@pdf, @format).render(section, translate_at)
        end
      end
    end
  end
end
