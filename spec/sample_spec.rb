# frozen_string_literal: true

RSpec.describe Sample do
  it "can add two numbers" do
    expect(Sample.add(3,4)).to eq(7)
  end

  it "can add subtract numbers" do
    expect(Sample.subtract(5,2)).to eq(3)
  end

  it "can divide two numbers" do
    expect(Sample.divide(10, 2)).to eq(5)
    expect(Sample.divide(15, 3)).to eq(5)
  end

  it "raises error when dividing by zero" do
    expect { Sample.divide(10, 0) }.to raise_error(ZeroDivisionError, "Division by zero is not allowed.")
  end
  
  it "can calculate modulo" do
    expect(Sample.modulo(10, 3)).to eq(1)
    expect(Sample.modulo(20, 7)).to eq(6)
    expect(Sample.modulo(15, 5)).to eq(0)
  end

  it "raises error when modulo by zero" do
    expect { Sample.modulo(10, 0) }.to raise_error(ZeroDivisionError, "Modulo by zero is not allowed.")
  end
end
