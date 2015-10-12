require 'spec_helper'

describe Imagemagick::CollageMaker do

  it 'should make histograms' do
    res = Imagemagick::CollageMaker.new([picture_file('flowers/1.jpg')], temp_file).make
    expect(File.exists?(res)).to be_truthy
  end

  def temp_file
    app_root.join("tmp/imagemagick_collage_maker_#{rand(1000)}.png").to_s
  end

end
