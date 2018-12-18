# frozen_string_literal: true

module Thinreports
  module Pdf
    class Document
      module Text
        class TextBox
          # @param [Thinreports::Pdf::Document] pdf
          # @param [String] content
          # @param [Numeric, String] x
          # @param [Numeric, String] y
          # @param [Numeric, String] width
          # @param [Numeric, String] height
          # @param [Hash] attrs ({})
          # @option attrs [String] :font
          # @option attrs [Numeric, String] :size
          # @option attrs [String] :color
          # @option attrs [Array<:bold, :italic, :underline, :strikethrough>]
          #   :styles (nil)
          # @option attrs [:left, :center, :right] :align (:left)
          # @option attrs [:top, :center, :bottom] :valign (:top)
          # @option attrs [Numeric, String] :line_height The total height of an text line.
          # @option attrs [Numeric, String] :letter_spacing
          # @option attrs [Boolean] :single (false)
          # @option attrs [:trancate, :shrink_to_fit, :expand] :overflow (:trancate)
          # @option attrs [:none, :break_word] :word_wrap (:none)
          def initialize(pdf, content, x, y, width, height, attrs = {})
            @pdf = pdf
            @content = content
            @x, @y, @width, @height = normalize_number(x, y, width, height)
            @attrs = attrs
          end

          def render
            with_state { pdf.formatted_text_box() }
          end

          def height
            with_state { pdf.height_of_formatted() }
          end

          private

          attr_reader :pdf, :width, :height, :attrs

          def state(&block)
            pdf.save_graphics_state do
              block.call
            end
          end

          def position
            @position ||= pdf.map_to_upper_left_position(@x, @y)
          end
        end
      end
    end
  end
end
