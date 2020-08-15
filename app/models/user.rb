class User < ApplicationRecord
    has_many :events, foreign_key: :creator_id
    has_many :event_attendances
    has_many :attended_events, through: :event_attendances, source: :event
    
    has_many :sent_invites, class_name: 'Invite', foreign_key: 'inviter_id'
    has_many :received_invites, class_name: 'Invite', foreign_key: 'invited_id'
end
