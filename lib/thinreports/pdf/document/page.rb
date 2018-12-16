# frozen_string_literal: true

module Thinreports
  module Pdf
    class Document
      module Page
        JIS_SIZES = {
          'B4' => [728.5, 1031.8],
          'B5' => [515.9, 728.5]
        }.freeze

        def start_new_page(layout:, size:)
          pdf.start_new_page(layout: layout, size: normalize_page_size(size))
        end

        def add_blank_page
          pdf.start_new_page(pdf.page_count.zero? ? { size: 'A4' } : {})
        end

        private

        def normalize_page_size(size)
          return size if size.is_a?(Array)

          case size
          when 'B4_ISO', 'B5_ISO'
            size.delete('_ISO')
          when 'B4', 'B5'
            JIS_SIZES[size]
          else
            size
          end
        end
      end
    end
  end
end
