require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SdbBackup do

  context "#initialize" do

    it "requires a reader and writer" do
      lambda { SdbBackup.new }.should raise_error(ArgumentError)
    end

    it "accepts a reader and writer" do
      lambda { SdbBackup.new(
        mock(SdbBackup::Reader::SdbDomain), 
        mock(SdbBackup::Writer::SdbDomain)) 
      }.should_not raise_error
    end
  end
end
