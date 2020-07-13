# frozen_string_literal: true

require 'feature_test'

class TestSectionReportStackViewFeature < FeatureTest
  feature :section_report_stack_view do
    params = {
      type: :section,
      layout_file: template_path,
      params: {
        groups: [
          {
            details: [
              {
                id: :detail,
                items: {
                  stackview1: {
                    rows: {
                      row2: {
                        items: {
                          text: 'text block'
                        }
                      }
                    }
                  },
                  stackview2: {
                    rows: {
                      row2: {
                        display: false
                      },
                      row3: {
                        display: false
                      },
                      nonexistent_row: {
                        items: {
                          any_item: 'nonexistent rows and items within them are ignored'
                        }
                      }
                    }
                  }
                }
              }
            ]
          }
        ]
      }
    }
    assert_pdf Thinreports.generate(params)
  end
end
