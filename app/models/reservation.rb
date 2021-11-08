class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :schedule
	belongs_to :sheet

	validates :name, presence: true
	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
							format: { with: VALID_EMAIL_REGEX }
	validates :sheet_id, uniqueness: { scope: [:date, :schedule_id] }
end
