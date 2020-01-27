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

    sanitize_input.flatten
  end

  private

  def sanitize_input
    @input.split("\n").map do |row|
      jobs_str = row.gsub(/[^a-z]/i, '')
      jobs = jobs_str.chars
    end
  end
end
