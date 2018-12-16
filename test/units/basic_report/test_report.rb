# frozen_string_literal: true

require 'test_helper'

class Thinreports::BasicReport::TestReport < Minitest::Test
  include Thinreports::TestHelper

  # Alias
  Report = Thinreports::BasicReport::Report

  def test_new
    assert_instance_of Report::Base, Report.new
  end

  def test_create
    assert_instance_of Report::Base, Report.create {}
  end

  def test_alias
    assert_equal Thinreports::BasicReport::Report, Thinreports::Report
  end
end
