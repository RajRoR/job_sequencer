# frozen_string_literal: true

require 'spec_helper'

describe JobSequencer do
  context 'input string' do
    let(:input) { '' }

    before do
      job_sequencer = described_class.new(input)
      @response = job_sequencer.find_sequence
    end

    context 'when blank' do
      it 'returns an empty array' do
        expect(@response.class).to eq(Array)
        expect(@response).to be_empty
      end
    end

    context 'single job' do
      let(:input) { 'a => ' }

      it 'returns array with required single job' do
        expect(@response.class).to eq(Array)
        expect(@response).to eq(['a'])
      end
    end
  end
end
