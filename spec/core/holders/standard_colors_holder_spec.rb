describe Incollage::StandardColorsHolder do
  let(:holder) { described_class.new }
  let(:args) do
    { name: 'Green', hex_value: '00ff00' }
  end

  it 'should contain colors' do
    expect(holder.added_colors).to be_empty

    expect(holder.has_value?('00ff00')).to be_falsey

    holder.add(args)

    expect(holder.has_value?('00ff00')).to be_truthy

    expect(->{
      holder.add(args)
    }).to raise_error(ArgumentError)

    holder.add(name: 'Red', hex_value: 'ff0000')

    expect(holder.added_colors.map &:name).to eq(%w(Green Red))
  end
end
