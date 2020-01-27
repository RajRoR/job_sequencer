#!/usr/bin/env ruby
require './lib/job_sequencer.rb'

JobSequencer.new.run(ARGV.first)
