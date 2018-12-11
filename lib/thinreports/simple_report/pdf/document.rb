# frozen_string_literal: true

require_relative 'draw_template_items'

module Thinreports
  module SimpleReport
    module Pdf
      class Document < Thinreports::Pdf::Document
        include DrawTemplateItems

        def start_new_page(format)
          format_id =
            if change_page_format?(format)
              super(page_params(format))
              @current_page_format = format

              create_format_stamp(format) unless format_stamp_registry.include?(format.identifier)
              format.identifier
            else
              super(page_params(current_page_format))
              current_page_format.identifier
            end

          stamp(format_id.to_s)
        end

        # @return [Thinreports::SimpleReport::Layout::Format]
        attr_reader :current_page_format

        # @param [Numeric, String] x
        # @param [Numeric, String] y
        def translate(x, y, &block)
          x, y = rpos(x, y)
          pdf.translate(x, y, &block)
        end

        # @param [String] stamp_id
        # @param [Array<Numeric>] at (nil)
        def stamp(stamp_id, at = nil)
          if at.nil?
            pdf.stamp(stamp_id)
          else
            pdf.stamp_at(stamp_id, rpos(*at))
          end
        end

        # Delegate to Prawn::Document#create_stamp
        # @param [String] id
        # @see Prawn::Document#create_stamp
        def create_stamp(id, &block)
          pdf.create_stamp(id, &block)
        end

        # @param [Thinreports::SimpleReport::Layout::Format] new_format
        # @return [Boolean]
        def change_page_format?(new_format)
          !current_page_format ||
            current_page_format.identifier != new_format.identifier
        end

        # @param [Thinreports::SimpleReport::Layout::Format] format
        def create_format_stamp(format)
          create_stamp(format.identifier.to_s) do
            draw_template_items(format.attributes['items'])
          end
          format_stamp_registry << format.identifier
        end

        # @return [Array]
        def format_stamp_registry
          @format_stamp_registry ||= []
        end

        # @param [Thinreports::SimpleReport::Layout::Format] format
        # @return [Hash]
        def page_params(format)
          page_size = if format.user_paper_type?
                        [format.page_width.to_f, format.page_height.to_f]
                      else
                        format.page_paper_type
                      end
          {
            layout: format.page_orientation.to_sym,
            size: page_size
          }
        end
      end
    end
  end
end
