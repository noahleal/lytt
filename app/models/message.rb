class Message < ApplicationRecord
  belongs_to :session
  validates :language_support
  validates :identifier, uniqueness: true

  private

  def language_supported?
    detected_language == "english" || detected_language == "german" || detected_language == "spanish"
  end

  def language_support
    unless language_supported?
      errors.add(:detected_language, 422, message: "Unfortunately we don't have support for your language yet.")
    end

  end

end
