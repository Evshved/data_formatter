# frozen_string_literal: true

require 'date'
require 'integer_patch'
require_relative 'equal_checker'
require_relative 'time_range_performer'
require_relative 'time_range_printer'

class DateRangeFormatter
  include EqualChecker
  include TimeRangePerformer
  include TimeRangePrinter

  attr_reader :start_time, :end_time, :start_date, :end_date

  def initialize(start_date, end_date, start_time = nil, end_time = nil)
    @start_date = parse_date(start_date)
    @end_date = parse_date(end_date)
    @start_time = parse_time(start_time)
    @end_time = parse_time(end_time)
  end

  def to_s
    return prepare_day_range if equal_day?
    return prepare_month_range if equal_month?
    return prepare_year_range if equal_year?

    perform_date_range
  end

  private

  def parse_date(date)
    Date.parse(date)
  end

  def parse_time(time)
    return nil unless time

    DateTime.parse(time)
  end
end
