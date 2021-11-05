class Schedule < ApplicationRecord
	belongs_to :movie
	has_many :reservations

	validates :screen_id, uniqueness: true, presence: true
end
