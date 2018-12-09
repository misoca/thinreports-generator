# frozen_string_literal: true

require 'prawn'

require_relative 'prawn_ext'
require_relative 'document/font'
require_relative 'document/graphics'
require_relative 'document/image'
require_relative 'document/page'
require_relative 'document/parse_color'
require_relative 'document/text'

module Thinreports
  module Pdf
    class Document
      include Utils

      include Pdf::Font
      include Pdf::Graphics
      include Pdf::Image
      include Pdf::Page
      include Pdf::ParseColor
      include Pdf::Text

      # @return [Prawn::Document]
      attr_reader :pdf

      # @param [String] title (nil)
      # @param [Hash] security (nil)
      def initialize(title: nil, security: nil)
        @pdf = Prawn::Document.new(
          skip_page_creation: true,
          margin: [0, 0],
          info: {
            CreationDate: Time.now,
            Creator: 'Thinreports Generator for Ruby ' + Thinreports::VERSION,
            Title: title
          }
        )
        # Setup to Prawn::Document.
        setup_fonts
        setup_default_graphic_state

        # Encrypts the document.
        @pdf.encrypt_document(security) if security
      end

      # Delegate to Prawn::Document#render
      # @see Prawn::Document#render
      def render
        result = pdf.render
        finalize
        result
      end

      # Delegate to Prawn::Document#render_file
      # @see Prawn::Document#render_file
      def render_file(*args)
        finalize
        pdf.render_file(*args)
      end

      # @see #pdf
      def internal
        @pdf
      end

      private

      def finalize
        clean_temp_images
      end

      # @param [Array<String, Numeric>] values
      # @return [Numeric, Array<Numeric>, nil]
      def s2f(*values)
        return nil if values.empty?

        if values.size == 1
          value = values.first
          return nil unless value
          value.is_a?(::Numeric) ? value : value.to_f
        else
          values.map { |v| s2f(v) }
        end
      end

      # @param [Numeric, String] x
      # @param [Numeric, String] y
      # @return [Array<Float>]
      def map_to_upper_left_relative_position(x, y)
        x, y = s2f(x, y)
        [x, -y]
      end
      alias rpos map_to_upper_left_relative_position

      # @param [Numeric, String] x
      # @param [Numeric, String] y
      # @return [Array<Float>]
      def map_to_upper_left_position(x, y)
        x, y = s2f(x, y)
        [x, pdf.bounds.height - y]
      end
      alias pos map_to_upper_left_position
    end
  end
end
