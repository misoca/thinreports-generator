# frozen_string_literal: true

module Thinreports
  module SimpleReport
    module Report
      # @see Thinreports::SimpleReport::Report::Base#initialize
      def self.new(*args)
        SimpleReport::Report::Base.new(*args)
      end

      # @see Thinreports::SimpleReport::Report::Base#create
      def self.create(*args, &block)
        SimpleReport::Report::Base.create(*args, &block)
      end

      # @see Thinreports::SimpleReport::Report::Base#generate
      def self.generate(*args, &block)
        SimpleReport::Report::Base.generate(*args, &block)
      end
    end
  end
end

require_relative 'report/base'
require_relative 'report/internal'
require_relative 'report/page'
