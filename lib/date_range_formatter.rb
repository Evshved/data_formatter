# frozen_string_literal: true

require 'date'
require 'fixnum'

class DateRangeFormatter
  TIME_CONFIG_PATTERNS = {
    date_format: '%%s %B %Y',
    time_prefix: 'at',
    time_format: '%H:%M'
  }.freeze

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

  def equal_day?
    start_date == end_date
  end

  def equal_month?
    start_date.month == end_date.month && start_date.year == end_date.year
  end

  def equal_year?
    start_date.year == end_date.year
  end

  private

  def parse_date(date)
    Date.parse(date)
  end

  def parse_time(time)
    return nil unless time

    DateTime.parse(time)
  end

  def perform_date(date, config)
    config = TIME_CONFIG_PATTERNS.merge(config)
    return date.day.ordinalize unless config[:date_format]

    date.strftime(config[:date_format]) % date.day.ordinalize
  end

  def perform_time(time, config)
    config = TIME_CONFIG_PATTERNS.merge(config)
    return '' unless time

    "#{config[:time_prefix]} #{time.strftime(config[:time_format])}".strip
  end

  def perform_date_time(type, config = {})
    config = TIME_CONFIG_PATTERNS.merge(config)
    human_date = perform_date(send("#{type}_date".to_sym), config)
    human_time = perform_time(send("#{type}_time".to_sym), config)
    "#{human_date} #{human_time}".strip
  end

  def perform_date_range
    "#{perform_date_time('start')} - #{perform_date_time('end')}".strip
  end

  def prepare_year_range
    start_time_starts = if start_time || end_time
                          perform_date_time('start')
                        else
                          perform_date(start_date, date_format: '%%s %B')
                        end
    "#{start_time_starts} - #{perform_date_time('end')}".strip
  end

  def prepare_month_range
    start_time_starts = if start_time || end_time
                          perform_date_time('start')
                        else
                          perform_date(start_date, date_format: nil)
                        end
    "#{start_time_starts} - #{perform_date_time('end')}".strip
  end

  def prepare_day_range
    end_time_ends = if start_time
                      perform_time(end_time, time_prefix: 'to')
                    else
                      perform_time(end_time, time_prefix: 'until')
                      end
    "#{perform_date_time('start')} #{end_time_ends}".strip
  end
end
