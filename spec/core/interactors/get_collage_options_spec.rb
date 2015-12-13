require 'spec_helper'

describe Incollage::GetCollageOptions do
  let(:response) { Incollage::GetCollageOptions.new.execute }
  subject { TarvitHelpers::HashPresenter.present(response) }

  before do |example|
    example.with_holders
  end

  it { expect(subject.search).to be }
  it { expect(subject.collage).to be }
  it { expect(subject.colors).to be }

end
