# frozen_string_literal: true

require_relative 'pdf/document'
require_relative 'renderer/base'
require_relative 'renderer/page'
require_relative 'renderer/list'
require_relative 'renderer/list_section'

module Thinreports
  module SimpleReport
    class Generator
      # @return [Thinreports::SimpleReport::Report::Base]
      attr_reader :report

      # @param [Thinreports::SimpleReport::Report::Base] report
      # @param [Hash] security (nil)
      def initialize(report, security: nil)
        report.finalize

        @report = report.internal
        title = default_layout ? default_layout.format.report_title : nil

        @document = SimpleReport::Pdf::Document.new(title: title, security: security)
        @renderers = {}
      end

      # @param [String, nil] filename
      # @return [String, nil]
      def generate(filename = nil)
        render_report
        filename ? @document.render_file(filename) : @document.render
      end

      def default_layout
        report.default_layout
      end

      private

      def render_report
        report.pages.each do |page|
          render_page(page)
        end
      end

      def render_page(page)
        return @document.add_blank_page if page.blank?

        format = page.layout.format
        add_page(format)

        page_renderer(format).render(page)
      end

      def page_renderer(format)
        @renderers[format.identifier] ||= Renderer::Page.new(@document, format)
      end

      def add_page(format)
        page_size =
          if format.user_paper_type?
            [format.page_width.to_f, format.page_height.to_f]
          else
            format.page_paper_type
          end

        @document.start_new_page(
          layout: format.page_orientation.to_sym,
          size: page_size
        )
      end
    end
  end
end
