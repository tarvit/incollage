describe Incollage::AccessCodesHolder do

  let(:holder) { Incollage::AccessCodesHolder.new }

  it 'should contain codes' do
    expect(holder.codes).to be_empty

    expect(holder.has?('abc')).to be_falsey

    holder.add('abc')

    expect(holder.has?('abc')).to be_truthy

    expect(->{
      holder.add('abc')
    }).to raise_error(ArgumentError)

    holder.add('xyz')

    expect(holder.codes).to eq(%w{ abc xyz })
  end
end
