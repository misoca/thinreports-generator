# frozen_string_literal: true

module Thinreports
  module SimpleReport
    module Pdf
      class Document < Thinreports::Pdf::Document
        # @param [String] stamp_id
        # @return [Boolean]
        def stamp_exist?(stamp_id)
          stamp_ids.include?(stamp_id)
        end

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
          stamp_ids << id
          pdf.create_stamp(id, &block)
        end

        private

        # @return [Array<String>]
        def stamp_ids
          @stamp_ids ||= []
        end
      end
    end
  end
end
