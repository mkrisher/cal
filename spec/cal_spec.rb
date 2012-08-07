describe Cal do
  describe "#display" do
    it "assumes the current year and month if not passed in options hash" do
      Cal.display
      Cal.instance_variable_get(:@year).should  == Date.today.year
      Cal.instance_variable_get(:@month).should == Date.today.month
    end

    it "utilizes an options hash that can include the year and month" do
      Cal.display({year: 2000, month: 1})
      Cal.instance_variable_get(:@year).should  == 2000
      Cal.instance_variable_get(:@month).should == 1
    end

    it "returns an html string" do
      Cal.display.class.should == String
      Cal.display.should match(/table/)
    end
  end
end
