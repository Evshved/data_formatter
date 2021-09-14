# frozen_string_literal: true

module TimeRangePrinter
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
