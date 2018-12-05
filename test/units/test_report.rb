# frozen_string_literal: true

require 'test_helper'

class Thinreports::TestReport < Minitest::Test
  include Thinreports::TestHelper

  def test_class_alias
    assert_equal Thinreports::SimpleReport::Report, Thinreports::Report
  end
end
