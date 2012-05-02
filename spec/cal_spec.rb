describe Cal do
  describe "#display" do
    it "displays the current month if no args are passed" do
      Cal.display.should == "#{Date.today.year} - #{Date.today.month}"
    end
  end
end
