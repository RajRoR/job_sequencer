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

    sanitize_input.each do |job, dependency|
      job_index = @final_sequence.index(job)

      # Check if there is no dependency or dependency was already added in @final_sequence

      if dependency && !@final_sequence.index(dependency)
        # Append the dependency and then the job
        @final_sequence += dependency

        if job_index
          # Find index of newly appended dependency
          new_dependency_index = @final_sequence.length - 1
          slicing_length = new_dependency_index - job_index

          str_to_shift = @final_sequence.slice!(job_index, slicing_length)
          @final_sequence.concat(str_to_shift)
        else
          @final_sequence += job
        end
      else
        @final_sequence += job unless job_index
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
      jobs_str.chars
    end
  end
end
