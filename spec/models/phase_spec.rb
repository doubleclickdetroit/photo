require 'spec_helper'

describe Phase do
  before(:each) do
    @project = Factory(:project)
    @phase   = Factory(:phase)
  end

  describe '.project' do
    before(:each) { @project.phases << @phase }
    subject { @phase.project }
    it { should be_an_instance_of(Project) }
  end
end
