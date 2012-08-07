describe Cal::Calculations do
  describe "#draw_calendar" do
    it "sets the date instance variable to beginning of current month as a default" do
      Cal::Calculations.draw_calendar
      Cal::Calculations.instance_variable_get(:@date).should  == Date.civil(Date.today.year, Date.today.month)
    end
    it "sets the date instance variable to beginning of month passed in" do
      Cal::Calculations.draw_calendar({year: 1999, month: 01})
      Cal::Calculations.instance_variable_get(:@date).should == Date.civil(1999, 01)
    end
    it "sets the event instance variable" do
      Cal::Calculations.draw_calendar
      Cal::Calculations.instance_variable_get(:@events).class.should == Hash
    end
    it "should return an html string" do
      Cal::Calculations.draw_calendar.class.should == String
      Cal::Calculations.draw_calendar.should match(/table/)
    end
    it "should call draw_table_nav" do
      Cal::Calculations.should_receive(:draw_table_nav).and_return("<tr><td></td></tr>")
      Cal::Calculations.draw_calendar
    end
    it "should call draw_table_header" do
      Cal::Calculations.should_receive(:draw_table_header).and_return("<tr><td></td></tr>")
      Cal::Calculations.draw_calendar
    end
    it "should call draw_table_body_first_row" do
      Cal::Calculations.should_receive(:draw_table_body_first_row).and_return("<tr><td></td></tr>")
      Cal::Calculations.draw_calendar
    end
    it "should call draw_table_body_rows" do
      Cal::Calculations.should_receive(:draw_table_body_rows).and_return("<tr><td></td></tr>")
      Cal::Calculations.draw_calendar
    end
  end

  describe "#draw_table_nav" do
    it "should return a string" do
      Cal::Calculations.draw_table_nav.class.should == String
    end
    it "should draw a row contain the month name" do
      Cal::Calculations.draw_calendar({year: 2012, month: 01})
      Cal::Calculations.draw_table_nav.should match(/January/)
    end
    it "should link to the previous month" do
      Cal::Calculations.draw_calendar({year: 2012, month: 01})
      Cal::Calculations.draw_table_nav.should match(/previous/)
    end
    it "should link to the next month" do
      Cal::Calculations.draw_calendar({year: 2012, month: 01})
      Cal::Calculations.draw_table_nav.should match(/next/)
    end
  end

  describe "#draw_table_header" do
    it "should return a string" do
      Cal::Calculations.draw_table_header.class.should == String
    end
    it "should draw a row containing all days of the week" do
      result = Cal::Calculations.draw_table_header
      arr    = %w(Sun Mon Tue Wed Thu Fri Sat)
      arr.each do |day|
        result.should match(/#{day}/)
      end
      result.scan('</th>').size.should == 7
    end
  end

  describe "#draw_table_body_first_row" do
    it "should return a string" do
      Cal::Calculations.draw_table_body_first_row.class.should == String
    end
    it "should draw a row with the first day of the month on the approriate weekday" do
      date = Date.civil(2012, 07) #wday is 0
      Cal::Calculations.instance_variable_set(:@date, date)
      result = Cal::Calculations.draw_table_body_first_row
      result.scan('</td>').size.should == 7
      Cal::Calculations.instance_variable_get(:@day).should == date.beginning_of_month + 7.days
    end
  end

  describe "#draw_table_body_rows" do
    it "should return a string" do
      Cal::Calculations.draw_table_body_rows.class.should == String
    end
    it "should return call #draw_week for the number of weeks required" do
      date = Date.civil(2012, 07) #wday is 0
      Cal::Calculations.instance_variable_set(:@date, date)
      times  = ((date.end_of_month.day + (date.beginning_of_month.wday - 1)) / 7).ceil
      Cal::Calculations.should_receive(:draw_week).exactly(times).times.and_return("<tr><td colspan='7'></td></tr>")
      Cal::Calculations.draw_table_body_rows
    end
  end

  describe "#draw_week" do
    it "should return a string" do
      Cal::Calculations.draw_week.class.should == String
    end
    it "should return a row padding days at the end if needed after drawing all months days" do
      date = Date.civil(2012, 07) #wday is 0
      Cal::Calculations.instance_variable_set(:@date, date)
      day = date.end_of_month
      Cal::Calculations.instance_variable_set(:@day, day)
      result = Cal::Calculations.draw_week
      result.scan('</td>').size.should      == 7
      result.scan(day.day.to_s).size.should == 1
      result.scan('no_date').size.should    == 6
    end
  end

  describe "#day_summary" do
    it "should expect a hash and return a string" do
      Cal::Calculations.day_summary({start_datetime: '2012-07-01', end_datetime: '2012-07-02', summary: 'test'}).class.should == String
    end
    it "should include start and endtime if they are included" do
      result = Cal::Calculations.day_summary({start_datetime: '2012-07-01', end_datetime: '2012-07-02', summary: 'test'})
      result.should == "12:00 AM - 12:00 AM test"
    end
    it "should simply return the summary if start and endtime are not included" do
      result = Cal::Calculations.day_summary({summary: 'test'})
      result.should == 'test'
    end
  end

  describe "#classes" do
    before(:each) do
      @events = {event1: {start_date: '2012-07-01', end_date: '2012-07-02', summary: 'test'}, event2: {start_date: '2012-07-03', end_date: '2012-07-04', summary: 'another test'}}
    end
    it "should expect a hash of events and a date and return a string" do
      Cal::Calculations.classes(@events, Date.today).class.should == String
    end
  end

  describe "#data_hase_event" do
    it "should return false if there is not an event on the given date" do
      @events = {event1: {start_date: '2012-07-01', end_date: '2012-07-02', summary: 'test'}, event2: {start_date: '2012-07-03', end_date: '2012-07-04', summary: 'another test'}}
      Cal::Calculations.date_has_event(@events.first, Date.today).should == false
    end
  end

  describe "#event_output" do
    #it "should return a string" do
    #  Cal::Calculations.event_output.class.should == String
    #end
  end
end
