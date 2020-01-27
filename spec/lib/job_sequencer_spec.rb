# frozen_string_literal: true

require 'spec_helper'

describe JobSequencer do
  context 'input string' do
    let(:input) { '' }
    let(:job_sequencer) { described_class.new(input) }

    context 'positive cases' do
      before do
        @response = job_sequencer.find_sequence
        expect(@response.class).to eq(String)
      end

      context 'when blank' do
        it 'returns an empty array' do
          expect(@response).to be_empty
        end
      end

      context 'single job' do
        let(:input) { 'a => ' }

        it 'returns array with required single job' do
          expect(@response).to eq('a')
        end
      end

      context 'multiple independent jobs' do
        let(:input) { File.open('./spec/factories/multiple_independent_jobs.txt').read }

        it 'returns array of required job sequence' do
          expect(@response).to eq('abc')
        end
      end

      context 'having a dependent job' do
        let(:input) { File.open('./spec/factories/dependent_job.txt').read }

        it 'returns array of required job sequence' do
          expect(@response.index('c')).to be < @response.index('b')

          expect(@response).to eq('acb')
        end
      end

      context 'having multiple jobs having dependency' do
        let(:input) { File.open('./spec/factories/multiple_jobs_having_dependency.txt').read }

        it 'returns array of required job sequence' do
          expect(@response.index('f')).to be < @response.index('c')
          expect(@response.index('c')).to be < @response.index('b')
          expect(@response.index('b')).to be < @response.index('e')
          expect(@response.index('a')).to be < @response.index('d')

          expect(@response).to eq('afcbde')
        end
      end
    end

    context 'negative cases' do
      context 'having self dependencies' do
        let(:input) { File.open('./spec/factories/job_having_dependency.txt').read }

        it 'raises expcetion - CustomException::SelfDependencyException' do
          expect { job_sequencer.find_sequence }.to raise_error(CustomException::SelfDependencyException)
        end
      end
    end
  end
end
