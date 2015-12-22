require_relative 'spec_helper'

describe 'test::insert_line_after_match' do
  let(:chef_run) do
    allow(File).to receive(:read).and_call_original
    expect(File).to receive(:read).with("/test1").and_return('test')
    expect(File).to receive(:read).with("/test2/path.txt").and_return('test')

    ChefSpec::SoloRunner.new(step_into: ['insert_line_after_match']).converge described_recipe
  end

  context '/test1' do
    it 'expect insert_line_after_match matcher to run' do
      expect(chef_run).to run_insert_line_after_match('/test1')
    end

    it 'expect ruby block to run' do
      expect(chef_run).to run_ruby_block('/test1')
    end
  end

  context 'test2' do
    it 'expect insert_line_after_match matcher to run' do
      expect(chef_run).to run_insert_line_after_match('test2')
    end

    it 'expect ruby block to run' do
      expect(chef_run).to run_ruby_block('test2')
    end
  end

  context 'test3' do
    it 'expect insert_line_after_match matcher to not run' do
      expect(chef_run).not_to run_insert_line_after_match('test3')
    end
  end
end
