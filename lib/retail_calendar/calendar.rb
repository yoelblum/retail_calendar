module RetailCalendar
  class Calendar
    def initialize(type: 445, year_end_month: 1)
      raise ArgumentError, "Bad calendar type #{type}" unless [544, 454, 445].include?(type)
      raise ArgumentError, "Bad year-end month #{year_end_month}" unless year_end_month.between?(1, 12)

      @type = type
      @yr_end_mo = year_end_month
    end

    # Return the ending date for a particular year
    def end_of_year(year)
      year += 1 unless @yr_end_mo == 12
      year_end = Date.new year, @yr_end_mo, -1
      wday = (year_end.wday + 1) % 7 # Saturday-origin day-of-week
      # Advance or retreat to closest Saturday
      if wday > 3 then year_end += 7 - wday
      elsif wday > 0 then year_end -= wday
      end
      year_end
    end

    # Return starting of retail date for a particular year
    def start_of_year(year)
      end_of_year(year - 1) + 1
    end

    # Returns the start of the retail_year for the given date
    def start_of_year_by_date(date)
      date -= 1.year if date < start_of_year(date.year)
      start_of_year(date.year)
    end

    # Return starting date for a particular month
    # @param: month[Integer] the retail month of the year
    def start_of_month(year, month)
      start = start_of_year(year) + ((month - 1) / 3).to_i * 91
      case @type * 10 + (month - 1) % 3
      when 4451, 4541 then start += 28
      when 5441 then start += 35
      when 4452 then start += 56
      when 4542, 5442 then start += 63
      end
      start
    end

    # Return the ending date for a particular month
    def end_of_month(year, month)
      if month == 12 then end_of_year year
      else start_of_month(year, month + 1) - 1
      end
    end

    # Return the number of weeks in a particular year
    def weeks_in_year(year)
      ((start_of_year(year + 1) - start_of_year(year)) / 7).to_i
    end

    # What week it is within the retail year from 1-53
    # @return [Integer] The week number of the year, from 1-53
    def year_week(date)
      (((date - start_of_year_by_date(date)) + 1) / 7.0).ceil
    end

    # what month it is within the retail year for a given date
    def year_month(date)
      month = date.month
      RetailCalendar.julian_to_merch(month)
    end

    # accetps retail week (1..53) and returns the week's date
    def retail_week_to_date(retail_week, year)
      start_week =  start_of_year(year) + (retail_week - 1).weeks
      { start_week: start_week, end_week: start_week + 6.days }
    end

    # Converts a retail month to the correct julian month
    # @param merch_month [Integer] the merch month to convert
    # @return [Integer] the julian month
    def self.merch_to_julian(merch_month)
      raise ArgumentError if merch_month > 12 || merch_month <= 0

      if merch_month == 12
        1
      else
        merch_month + 1
      end
    end

    # Converts a julian month to a retail month
    # @param julian_month [Integer] the julian month to convert
    # @return [Integer] the merch month
    def self.julian_to_merch(julian_month)
      raise ArgumentError if julian_month > 12 || julian_month <= 0

      if julian_month == 1
        12
      else
        julian_month - 1
      end
    end
  end
end
