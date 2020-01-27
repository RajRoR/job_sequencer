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
    @final_sequence = ''
  end

  # Find the sequence of jobs according to dependencies
  #
  # @return [String]: ordered jobs based on dependencies
  def find_sequence
    return '' if @input.is_blank?

    @final_sequence = ''
    sanitize_input.each do |job, dependency|
      dependency_index = @final_sequence.index(dependency)

      if dependency_index
        # Append the job if dependency is already satisfied
        @final_sequence += job
      else
        # Append the dependency and then the job
        @final_sequence += dependency.strip
        @final_sequence += job unless @final_sequence.index(job)
      end
    end

    @final_sequence
  end

  private

  # Sanitize raw input string to get nested array.
  #
  # @return [Array]: array of arrays where each internal array
  #                  contains job and it's dependency
  def sanitize_input
    @input.split("\n").map do |row|
      jobs_str = row.gsub(/[^a-z]/i, '')

      # Make sure to return blank as dependency of doesn't exists
      if jobs_str.length == 2
        jobs_str.chars
      else
        [jobs_str, ' ']
      end
    end
  end
end
