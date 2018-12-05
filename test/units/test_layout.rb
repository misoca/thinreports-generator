# frozen_string_literal: true

require 'test_helper'

class Thinreports::TestLayout < Minitest::Test
  include Thinreports::TestHelper

  def test_class_alias
    assert_equal Thinreports::SimpleReport::Layout, Thinreports::Layout
  end
end
