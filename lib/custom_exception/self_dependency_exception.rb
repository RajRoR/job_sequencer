# frozen_string_literal: true

module CustomException
  # Class SelfDependencyException - To handle self dependency exception
  class SelfDependencyException < StandardError
    def initialize
      message = 'Self dependent job found: The Job cannot depend on itself'
      super(message)
    end
  end
end
