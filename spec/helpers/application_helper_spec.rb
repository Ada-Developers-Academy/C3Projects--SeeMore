require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  context "#display_pacific_time" do
    let(:time1) { Date.parse("2012-10-31 15:50:13.793654 +0000 UTC") }
    let(:time2) { Date.parse("2009-11-17 20:34:58.651387237 +0000 UTC") }
    let(:time3) { Date.parse("2006-12-05 01:19:43.509120474 +0000 UTC") }

    it "takes in a date-time-y object and spits out a nicely formatted string" do
      expect(display_pacific_time(time1)).to eq("12:00AM Wednesday, October 31, 2012 (PDT)")
      expect(display_pacific_time(time2)).to eq("12:00AM Tuesday, November 17, 2009 (PST)")
      expect(display_pacific_time(time3)).to eq("12:00AM Tuesday, December  5, 2006 (PST)")
    end
  end
end
