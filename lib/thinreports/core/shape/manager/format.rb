# frozen_string_literal: true

require 'digest/sha1'

module Thinreports
  module Core
    module Shape
      module Manager
        class Format < Core::Format::Base
          # @return [String]
          def identifier
            @identifier ||= Digest::SHA1.hexdigest(attributes.to_s)
          end

          def find_shape(id)
            shapes[id]
          end

          def has_shape?(id)
            shapes.key?(id)
          end

          def shapes
            @shapes ||= {}
          end
        end
      end
    end
  end
end
