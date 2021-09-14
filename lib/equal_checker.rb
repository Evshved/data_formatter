# frozen_string_literal: true

module EqualChecker
  def equal_day?
    start_date == end_date
  end

  def equal_month?
    start_date.month == end_date.month && start_date.year == end_date.year
  end

  def equal_year?
    start_date.year == end_date.year
  end
end
