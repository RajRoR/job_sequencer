# frozen_string_literal: true

require_all 'lib/ext'

# Class JobSequencer - Responsible to run the provided input string of jobs
# Initialize class, JobSequencer
#
# @param [String] string input
# @return [JobSequencer]
class JobSequencer
  def initialize(input)
    raise ArgumentError, "Input can't be nil" unless input

    @input = input
  end

  # Find the sequence of jobs according to dependencies
  #
  # @return [Array]: ordered jobs based on dependencies
  def find_sequence
    return [] if @input.is_blank?

    sanitize_input.flatten
  end

  private

  # Sanitize raw input string to get nested array.
  #
  # @return [Array]: array of arrays where each internal array
  #                  contains job and it's dependency
  def sanitize_input
    @input.split("\n").map do |row|
      jobs_str = row.gsub(/[^a-z]/i, '')
      jobs = jobs_str.chars
    end
  end
end
