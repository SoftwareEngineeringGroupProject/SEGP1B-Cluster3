class Message < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :title, :text, :sender_id, :recipient_id
end
