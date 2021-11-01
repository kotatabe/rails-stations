class Reservation < ApplicationRecord
	belongs_to :schedule

	validates :name, presence: true
	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
							format: { with: VALID_EMAIL_REGEX }
	validates :date, uniqueness: { scope: [:schedule_id, :sheet_id] }
end
