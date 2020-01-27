# frozen_string_literal: true

require_all 'lib/ext'

# Class JobSequencer - Responsible to run the provided input string of jobs
class JobSequencer
  def initialize(input)
    raise ArgumentError, "Input can't be nil" unless input

    @input = input
  end

  def find_sequence
    return [] if @input.is_blank?
  end
end
