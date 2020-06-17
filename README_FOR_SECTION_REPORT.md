# SectionReport

A section-report format is a new template file format that is proposed at [the feature concept by Thinreports community](https://github.com/thinreports/thinreports/issues/7).

## Getting Started

### Prerequisites

To generate PDF with the section-report format, you need a template (tlf) file for the section-report format.
You have to use [this new Thinreports Editor](https://github.com/misoca/thinreports-editor) to create a template file for the section-report format.

### Installing

Add this line to your Gemfile:

```ruby
gem 'thinreports-generator', github: 'misoca/thinreports-generator', branch: 'section-report'
```

Then, execute `bundle install`.

### Generating PDF

```ruby
require 'thinreports'

params = {
  type: :section,
  layout_file: '/path/to/section-report-format-template.tlf',
  groups: [
    {
      details: [
        {
          id: :detail,
          items: {
            price: 1000
          }
        }
      ]
    }
  ]
}
Thinreports.generate(params, filename: 'sample.pdf')
```

See [features/section_report_basic](test/features/section_report_basic/README.md) for details.

## Examples

- [Basic Usage](test/features/section_report_basic/README.md)
- [Multiple Groups](test/features/section_report_multiple_groups/README.md)
- [Section Auto Stretch](test/features/section_report_section_auto_stretch/README.md)
- [Section Bottom Margin](test/features/section_report_section_bottom_margin/README.md)
- [Section Parameters](test/features/section_report_section_parameters/README.md)
- [Item Follow Stretch](test/features/section_report_item_follow_stretch/README.md)
- [Item Parameters](test/features/section_report_item_parameters/README.md)
- [StackView](test/features/sectiono_report_stack_view/README.md)
- [StackViewRow Auto Stretch](test/features/section_report_stack_view_row_auto_stretch/README.md)
- [StackViewRow Bottom Margin](test/features/section_report_stack_view_row_bottom_margin/README.md)
- [StackViewRow Parameters](test/features/section_report_stack_view_row_parameters/README.md)
- [StackView with Floating Item](test/features/section_report_stack_view_with_floating_item/README.md)
- [TextBlock Vertical Align](test/features/section_report_text_block_vertical_align/README.md)

## Implementation Status

Here is the current implementation status based on [the feature concept by Thinreports community](https://github.com/thinreports/thinreports/issues/7)

### Not Implemented

- `fixed at the bottom` property for footer sections
- page-number item

### Additional Features

- stack-view item
  - See [StackView](test/features/section_report_stack_view/README.md) for details
- `offset_x` and `offset_y` parameters for item position translation
  - See [Item Parameter](test/features/section_report_item_parameters/README.md) for details
  - Limitation: Only supports image-block items
- automatic shrink
  - See [Section Auto Stretch](test/features/section_report_section_auto_stretch/README.md) and [StackViewRow Auto Stretch](test/features/section_report_stack_view_row_auto_stretch/README.md) for details
  - Limitation: Sections and stack-view-rows shrink only by image-block items whose `vertical-align` property is `top`.
- `follow-stretch` property, which specifies how to change the layout of an item according to the stretch of the section or the stack-view-row
  - See [Item Follow Stretch](test/features/section_report_item_follow_stretch/README.md) for details
  - Limitation: Some item types are not supported

### Known Issues

- performance problem
  - The height calculations of sections or stack-view-rows are called several times
