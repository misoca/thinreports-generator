# frozen_string_literal: true

require_relative 'items'
require_relative 'template'

module Thinreports
  module SimpleReport
    module Renderer
      class Page < Base
        # @param [Thinreports::SimpleReport::Report::Page] page
        def render(page)
          render_template(page.layout.format)
          render_items(page)
        end

        private

        def render_template(page_format)
          format_id = "page-#{page_format.identifier}"

          create_stamp(format_id) do
            Renderer::Template.new(@pdf, page_format).render
          end

          @pdf.stamp(format_id)
        end

        def render_items(page)
          Renderer::Items.new(@pdf, @format).render(page)
        end
      end
    end
  end
end
