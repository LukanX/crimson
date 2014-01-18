class Period < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :start_date, presence: true
  require 'date'

  def next_period
    @next_period ||= User.find_by_id(user_id).periods.find_by_id(id + 1)
  end

  def period_interval
    unless next_period.nil?
    next_period.start_date.mjd - start_date.mjd
    end
  end

  def duration
    end_date.mjd - start_date.mjd
  end

end
