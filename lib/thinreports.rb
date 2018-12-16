# frozen_string_literal: true

require 'pathname'

module Thinreports
  def self.root
    @root ||= Pathname.new(__FILE__).join('..', '..')
  end
end

require_relative 'thinreports/version'
require_relative 'thinreports/config'
require_relative 'thinreports/core/utils'
require_relative 'thinreports/core/errors'
require_relative 'thinreports/core/format/base'
require_relative 'thinreports/core/shape'
require_relative 'thinreports/core/utils'
require_relative 'thinreports/item_renderer/text_block'
require_relative 'thinreports/item_renderer/image'
require_relative 'thinreports/item_renderer/page_number'
require_relative 'thinreports/item_renderer/image_block'
require_relative 'thinreports/item_renderer/text'
require_relative 'thinreports/item_renderer/ellipse'
require_relative 'thinreports/item_renderer/line'
require_relative 'thinreports/item_renderer/rect'
require_relative 'thinreports/pdf/document'

require_relative 'thinreports/basic_report/layout'
require_relative 'thinreports/basic_report/report'
require_relative 'thinreports/basic_report/generator'
