# frozen_string_literal: true

require 'test_helper'

class Thinreports::SimpleReport::TestLayout < Minitest::Test
  include Thinreports::TestHelper

  def test_new
    assert_instance_of Thinreports::SimpleReport::Layout::Base,
                       Thinreports::SimpleReport::Layout.new(layout_file.path)
  end
end
