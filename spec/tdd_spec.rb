require 'rspec'
require 'tdd'

describe 'Array#my_uniq' do
  let(:array) {[1, 2, 1, 3, 3]}
  it 'removes duplicate elements' do
    expect(array.my_uniq).to eq([1, 2, 3])
  end
  it 'returns a new array object' do
    expect(array.my_uniq).to_not be(array.uniq!)
  end
end

describe 'Array#two_sum' do
  it 'returns an array of paired positions that sum to zero' do
    expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
  end

  it 'returns an empty array if none sum to zero' do
    expect([1, 2, 3].two_sum).to be_empty
  end
end

describe 'my_transpose' do
  let(:array) {[
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]}

  it 'returns a transposed array' do
    expect(my_transpose(array)).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
  end

  it 'doesn\'t mutate original array' do
    my_transpose(array)
    expect(array).to be(array)
  end
end

describe 'stock_picker' do
  it 'returns the indexes of the biggest sequential positive gap' do
    array = [1,2,3,4,5]
    expect(stock_picker(array)).to eq([0,4])
  end

  it 'only returns sequential gaps' do
    array = [20, 1, 2, 3, 4, 5]
    expect(stock_picker(array)).to eq([1,5])
  end
end
