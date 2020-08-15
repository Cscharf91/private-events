class Event < ApplicationRecord
    scope :prev_events, -> { where('date < ?', DateTime.current) }
    scope :upcoming_events, -> { where('date > ?', DateTime.current) }

    has_many :invites, dependent: :destroy

    belongs_to :creator, class_name: "User"
    has_many :event_attendances, dependent: :destroy
    has_many :attendees, through: :event_attendances, source: :user
end
