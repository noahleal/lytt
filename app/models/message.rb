class Message < ApplicationRecord
  belongs_to :session
  validate :language_support
  validates :identifier, uniqueness: true

  private

  def language_supported?
    detected_language == "en" || detected_language == "de" || detected_language == "es"
  end

  def language_support
    unless language_supported?
      errors.add(:detected_language, 422, message: "Unfortunately we don't have support for your language yet.")
    end

  end

end
