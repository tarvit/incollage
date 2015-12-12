require 'spec_helper'

describe Incollage::AddClipping do

  before do |example|
    example.with_clipping_repo
  end

  subject do
    ->{
      described_class.new(TestFactories::ClippingFactory.defaults).execute
    }
  end

  it  do
    is_expected.to change {
      Incollage::Repository.for_clipping.count
    }.by(1)
  end

end
