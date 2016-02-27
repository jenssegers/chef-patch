require_relative 'spec_helper'

describe 'test::replace_line' do
  let(:chef_run) do
    allow(File).to receive(:read).and_call_original
    expect(File).to receive(:read).with("/test1").and_return('test')
    expect(File).to receive(:read).with("/test2/path.txt").and_return('test')

    ChefSpec::SoloRunner.new(step_into: ['replace_line']).converge described_recipe
  end

  context '/test1' do
    it 'expect replace_line matcher to run' do
      expect(chef_run).to run_replace_line('/test1')
    end
  end

  context 'test2' do
    it 'expect replace_line matcher to run' do
      expect(chef_run).to run_replace_line('test2')
    end
  end

  context 'test3' do
    it 'expect replace_line matcher to not run' do
      expect(chef_run).not_to run_replace_line('test3')
    end
  end
end
