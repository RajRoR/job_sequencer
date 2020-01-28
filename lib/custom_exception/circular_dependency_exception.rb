# frozen_string_literal: true

module CustomException
  # Class CircularDependencyException - To handle circular dependency exception
  class CircularDependencyException < StandardError
    def initialize
      message = 'Circular dependency found: Jobs should not be in Circular dependent'
      super(message)
    end
  end
end
