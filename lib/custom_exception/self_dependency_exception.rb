# frozen_string_literal: true

module CustomException
  class SelfDependencyException < StandardError
    def initialize
      message = 'Self dependent job found: The Job cannot depent on itself'
      super(message)
    end
  end
end