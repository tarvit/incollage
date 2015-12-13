require 'spec_helper'

describe Incollage::SearchClippingsForCollage do
  let(:args) { [{}, [], 1] }
  let(:instance) { described_class.new(*args) }

  before do |example|
    example.with_clipping_repo

    expect(Repository.for_clipping).to receive(:find_for_collage).with(*args).exactly(1).times
    instance.execute
  end
end
