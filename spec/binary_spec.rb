require 'spec_helper'

describe "Binary" do
  it "exits with a helpful message if the username is not provided" do
    out = `exe/fav_lang 2>&1`
    expect($?.exitstatus).to eq(1)
    expect(out).to match(/username/)
    expect(out).to match(/fav_lang \-h/)
  end

  it "prints the favourite language when it's found" do
    skip
    # Todo stub something
    out = `exe/fav_lang -u tadast`
    expect(out).to match(/Ruby/)
    expect($?.exitstatus).to eq(0)
  end
end
