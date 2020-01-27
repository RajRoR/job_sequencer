# frozen_string_literal: true

require 'spec_helper'

describe JobSequencer do
  it 'should return an empty array' do
    job_sequencer = described_class.new('')
    sequence = job_sequencer.find_sequence

    expect(sequence.class).to eq(Array)
    expect(sequence).to be_empty
  end
end
