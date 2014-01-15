class User < ActiveRecord::Base

  has_many :periods, dependent: :destroy
  accepts_nested_attributes_for :periods
  validates :name, presence: true
  validates :email, presence: true

  def durations
    @durations ||= periods.map(&:duration)
  end

  def average_duration
    durations.average
  end

  def duration_std_dev
    durations.standard_deviation.round(2)
  end

  def intervals
    @intervals ||= periods.map(&:period_interval).compact
  end

  def interval_std_dev
    intervals.standard_deviation.round(2)
  end


end
