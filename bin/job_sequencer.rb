#!/usr/bin/env ruby
# frozen_string_literal: true

require 'require_all'
require './lib/job_sequencer.rb'

job_sequencer = JobSequencer.new(ARGV.first)
puts job_sequencer.find_sequence.inspect
