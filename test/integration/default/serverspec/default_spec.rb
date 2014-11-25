require "spec_helper"

describe "inspeqtor::default" do
  it "installs Inspeqtor" do
    expect(package "inspeqtor").to be_installed
  end

  it "enables Inspeqtor service" do
    expect(service "inspeqtor").to be_enabled
  end

  it "starts Inspeqtor service" do
    expect(service "inspeqtor").to be_running
  end
end
