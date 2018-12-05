# frozen_string_literal: true

require 'test_helper'

class Thinreports::SimpleReport::TestReport < Minitest::Test
  include Thinreports::TestHelper

  # Alias
  Report = Thinreports::SimpleReport::Report

  def test_new
    assert_instance_of Report::Base, Report.new
  end

  def test_create
    assert_instance_of Report::Base, Report.create {}
  end
end
