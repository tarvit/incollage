require 'spec_helper'

describe Incollage::GetCollageOptions do

  before :each do
    @response = Incollage::GetCollageOptions.new.execute
    @response_object = TarvitHelpers::HashPresenter.present(@response)
  end

  it 'should get options' do
    expect(@response_object.search).to be
    expect(@response_object.collage).to be
    expect(@response_object.colors).to be
  end

end
