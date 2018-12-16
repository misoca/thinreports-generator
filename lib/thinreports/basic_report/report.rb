# frozen_string_literal: true

module Thinreports
  module BasicReport
    module Report
      # @see Thinreports::BasicReport::Report::Base#initialize
      def self.new(*args)
        BasicReport::Report::Base.new(*args)
      end

      # @see Thinreports::BasicReport::Report::Base#create
      def self.create(*args, &block)
        BasicReport::Report::Base.create(*args, &block)
      end

      # @see Thinreports::BasicReport::Report::Base#generate
      def self.generate(*args, &block)
        BasicReport::Report::Base.generate(*args, &block)
      end
    end
  end

  Report = BasicReport::Report
end

require_relative 'report/base'
require_relative 'report/internal'
require_relative 'report/page'
