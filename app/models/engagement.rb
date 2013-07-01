class Engagement < ActiveRecord::Base
  attr_accessible :customer_id, :name, :start_date, :end_date
  belongs_to :customer

  validates_presence_of :start_date
  validate :valid_end_time, if: -> { start_date.present? && end_date.present? }

  def valid_end_time
    if end_date < start_date
      errors.add(:end_date, "end-date cannot be on or before start-date")
    end
  end
end
