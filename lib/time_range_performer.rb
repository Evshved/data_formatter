# frozen_string_literal: true

module TimeRangePerformer
  TIME_CONFIG_PATTERNS = {
    date_format: '%%s %B %Y',
    time_prefix: 'at',
    time_format: '%H:%M'
  }.freeze

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
end
