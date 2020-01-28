# frozen_string_literal: true

require_all 'lib'

# Class JobSequencer - Responsible to run the provided input string of jobs
# Initialize class, JobSequencer
#
# @param [String] string input
# @return [JobSequencer]
#
class JobSequencer
  def initialize(input)
    raise ArgumentError, "Input can't be nil" unless input

    @input = input
    @final_sequence = ''
    # This will have @dependencies of jobs in order. It will help us to find dependency exceptions
    @dependencies = []
  end

  # Find the sequence of jobs according to @dependencies
  #
  # @return [String]: ordered jobs' sequence based on @dependencies
  #
  def find_sequence
    return '' if @input.blank?

    sanitize_input.each do |job, dependency|
      # Check for self-dependency
      raise CustomException::SelfDependencyException if job == dependency

      job_index = @final_sequence.index(job)

      # Check if there is no dependency or dependency was already added in @final_sequence
      if dependency
        # Raise exception if this job & dependency pair creates circular dependency
        raise CustomException::CircularDependencyException if circular_dependency_exists?(job, dependency)

        append_and_order_jobs(dependency, job, job_index) unless @final_sequence.index(dependency)
      end

      @final_sequence += job unless @final_sequence.include?(job)
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

  # Find if there is any circular dependency in the provided input
  #
  # @return [TrueClass or FalseClass]
  #
  def circular_dependency_exists?(job, dependency)
    dependencies_contain_job = @dependencies.detect { |n| n.include?(job) }
    dependencies_contain_dependency = @dependencies.detect { |n| n.include?(dependency) }

    if !dependencies_contain_job && !dependencies_contain_dependency
      @dependencies << "#{dependency}#{job}"
    elsif !dependencies_contain_dependency
      dix = @dependencies.index(dependencies_contain_job)
      dependencies_contain_job_dup = dependencies_contain_job.dup
      dependencies_contain_job_dup.insert(dependencies_contain_job.index(job), dependency)
      @dependencies[dix] = dependencies_contain_job_dup
    elsif !dependencies_contain_job
      jix = @dependencies.index(dependencies_contain_dependency)
      dependencies_contain_dependency_dup = dependencies_contain_dependency.dup
      dependencies_contain_dependency_dup += job
      @dependencies[jix] = dependencies_contain_dependency_dup
    end

    latest_final_sequence_making_circular_dependency?(job, dependency)
  end

  #
  # Check if after appending required job and dependency,
  # it makes circular dependency issue
  #
  # @return [TrueClass or FalseClass]
  #
  def latest_final_sequence_making_circular_dependency?(job, dependency)
    dependencies_contain_job = @dependencies.detect { |n| n.include?(job) }
    dependencies_contain_dependency = @dependencies.detect { |n| n.include?(dependency) }

    (
      dependencies_contain_dependency == dependencies_contain_job &&
        dependencies_contain_job.index(job) < dependencies_contain_job.index(dependency)
    )
  end

  #
  # It will append dependency and jobs to @final_sequence and
  # order then according to the dependency
  #
  def append_and_order_jobs(dependency, job, job_index)
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
  end
end
