class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save { |user| user.email = email.downcase }

  has_many :periods, dependent: :destroy
  accepts_nested_attributes_for :periods

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
      uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, :on => :save
  validates :password_confirmation, presence: true, :on => :save

  def durations
    @durations ||= periods.map(&:duration).compact.insert_values(4)
  end

  def average_duration
    durations.average
  end

  def duration_std_dev
    durations.standard_deviation.round(2)
  end

  def intervals
    @intervals ||= periods.map(&:period_interval).compact.insert_values(28)
  end

  def average_interval
    intervals.average
  end

  def interval_std_dev
    intervals.standard_deviation.round(2)
  end

  def last_period
    unless self.periods.empty?
      @last_period ||= self.periods.last
    else
      @last_period ||= nil
    end
  end

  def last_period_start
    @last_period_start ||= last_period.start_date
  end

  def period_prediction
    @period_prediction = last_period_start + average_interval
  end


end
