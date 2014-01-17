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
    @durations ||= periods.map(&:duration).compact
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

  def average_interval
    intervals.average
  end

  def interval_std_dev
    intervals.standard_deviation.round(2)
  end


end
