class Schedule < ApplicationRecord
	belongs_to :movie
	has_many :reservations
	has_one :screen

	validates :screen_id, uniqueness: true, presence: true
end
