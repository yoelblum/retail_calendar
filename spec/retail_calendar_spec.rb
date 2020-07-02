# frozen_string_literal: true

# The specs are best understood by looking at a 4-4-5 calendar
# https://www.calendarlabs.com/view/2020-accounting-period-calendar-4-4-5/1153
# https://www.calendarlabs.com/2021-accounting-calendar
require 'spec_helper'
require 'retail_calendar'
RSpec.describe RetailCalendar::Calendar do
  let(:instance) do
    described_class.new(type: 445, year_end_month: 1)
  end

  describe '::constructor' do
    it 'raises when bad calendar type' do
      expect { described_class.new(type: 'bleh') }.to raise_error(ArgumentError)
      expect { described_class.new(type: 454, year_end_month: 20) }.to raise_error(ArgumentError)
    end

    it 'wont raise for correct arguments' do
      expect { instance }.to_not raise_error
    end
  end

  describe '::start_of_year_by_date' do
    it 'returns start of year correctly' do
      expect(instance.start_of_year_by_date(Date.parse('2020-02-03')).to_s).to be_eql('2020-02-02')
      expect(instance.start_of_year_by_date(Date.parse('2021-01-30')).to_s).to be_eql('2020-02-02')
      expect(instance.start_of_year_by_date(Date.parse('2021-01-31')).to_s).to be_eql('2021-01-31')
    end
  end

  describe '::end_of_year' do
    it 'returns start of year correctly' do
      expect(instance.end_of_year(2020).to_s).to be_eql('2021-01-30')
      expect(instance.end_of_year(2021).to_s).to be_eql('2022-01-29')
    end
  end

  describe '::year_week' do
    it 'returns the numeric week within the retail year' do
      expect(instance.year_week(Date.parse('2020-04-19'))).to be_eql 12
      expect(instance.year_week(Date.parse('2021-01-24'))).to be_eql 52
      expect(instance.year_week(Date.parse('2021-01-30'))).to be_eql 52
      expect(instance.year_week(Date.parse('2021-01-31'))).to be_eql 1 # first retail week of 2021
    end
  end

  describe '::start_of_month' do
    it 'returns the start of merch month' do
      expect(instance.start_of_month(2020, 1).to_s).to be_eql('2020-02-02')
      expect(instance.start_of_month(2020, 2).to_s).to be_eql('2020-03-01')
      expect(instance.start_of_month(2020, 3).to_s).to be_eql('2020-03-29')
      expect(instance.start_of_month(2020, 5).to_s).to be_eql('2020-05-31')
    end
  end

  describe '::end_of_month' do
    it 'returns the end of month' do
      expect(instance.end_of_month(2020, 1).to_s).to be_eql('2020-02-29')
      expect(instance.end_of_month(2020, 2).to_s).to be_eql('2020-03-28')
      expect(instance.end_of_month(2020, 3).to_s).to be_eql('2020-05-02')
    end
  end

  describe '::retail_week_to_date' do
    it 'returns the retail weeks date' do
      expect(instance.retail_week_to_date(1, 2020)).to be_eql(start_week: Date.parse('2020-02-02'), end_week: Date.parse('2020-02-08'))
      expect(instance.retail_week_to_date(52, 2020)).to be_eql(start_week: Date.parse('2021-01-24'), end_week: Date.parse('2021-01-30'))
    end
  end

  describe '::weeks_in_year' do
    it 'returns weeks in year' do
      expect(instance.weeks_in_year(2020)).to be_eql(52)
      expect(instance.weeks_in_year(2021)).to be_eql(52)
    end
  end
end
