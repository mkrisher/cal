module Cal
  module Calculations
    extend self

    def draw_calendar(options = {year: Date.today.year, month: Date.today.month}, events = {})
      @date   = Date.civil(options[:year], options[:month])
      @events = events
      result  = "<table class='calendar' cellspacing='0'>"
      result  += draw_table_nav
      result  += draw_table_header
      result  += "<tbody>"
      result  += draw_table_body_first_row
      result  += draw_table_body_rows
      result  += "</tbody>"
      result  += "</table>"
    end

    def draw_table_nav
      result = "<thead><tr class='nav'>"
      result += "<th class='nav' colspan='2'>previous</th>"
      result += "<th class='nav' colspan='3'><h2>#{@date.strftime('%B')}</h2></th>"
      result += "<th class='nav' colspan='2'>next</th>"
      result += "</tr></thead>"
    end

    def draw_table_header
      arr     = %w(Sun Mon Tue Wed Thu Fri Sat)
      result  = "<thead><tr>"
      arr.each do |day|
        result += "<th>#{day}</th>"
      end
      result  += "</tr></thead>"
    end

    def draw_table_body_first_row
      @day    = @date.beginning_of_month
      padding = @day.wday
      result  = "<tr>"
      padding.times do
        result += "<td></td>"
      end
      (7 - padding).times do
        result += "<td #{classes({}, @day)}>#{@day.day}</td>"
        @day = @day + 1.day
      end
      result  += "</tr>"
    end

    def draw_table_body_rows
      result = ""
      weeks_required  = ((@date.end_of_month.day + (@date.beginning_of_month.wday - 1)) / 7).ceil
      weeks_required.times do
        result += draw_week
      end
      result
    end

    def draw_week
      result = "<tr>"
      padding = false
      7.times do |index|
        result += "<td #{classes(@events, @day)}>#{event_output(@events, @day)}</td>"
        if @day.day == @date.end_of_month.day
          # add colspan and exit
          offset = 7 - (index + 1)
          offset.times do
            result += "<td class='no_date'></td>"
          end
          break
        else
          @day = @day + 1.day
        end
      end
      result += "</tr>"
      result
    end

    def day_summary(event)
      if !event[:start_datetime].nil?
        result = Date.strptime(event[:start_datetime]).strftime('%I:%M %p')
        result += " - "
        result += Date.strptime(event[:end_datetime]).strftime('%I:%M %p')
        result += " #{event[:summary]}"
      else
        result = event[:summary]
      end
      result
    end

    def classes(events, date)
      classes = []
      classes << "today" if Date.today == date
      classes << "date_has_event" if date_has_event(events, date)
      "class='#{classes.join(" ")}'"
    end

    def date_has_event(event, date)
      events = @events.dup.delete_if do |event|
        event[:start_date].nil? || Date.strptime(event[:start_date]).day != date.day || Date.strptime(event[:start_date]).month != date.month
      end
      events.size > 0
    end

    def event_output(events, date)
      events = events.dup.delete_if do |event|
        event.start_date.nil? || Date.strptime(event.start_date).day != date.day || Date.strptime(event.start_date).month != date.month
      end
      if events.size > 0
        result = "#{date.day}<div class='events'><ul>"
        events.each do |event|
          result += "<li>"
          result += "<span class='title'>#{day_summary(event)}</span>"
          result += "</li>"
        end
        result += "</ul>"
        result += "</div>"
        result.html_safe
      else
        date.day
      end
    end
  end
end
