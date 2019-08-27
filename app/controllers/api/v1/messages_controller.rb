require 'whatlanguage/string'

class Api::V1::MessagesController < Api::V1::BaseController
  before_action :set_message, only: [:show]

  def create
    @session = Session.find_or_create_by(identifier: params[:session_id])
    @message = Message.new(session: @session, identifier: SecureRandom.hex(6), detected_language: params[:text].language_iso)

    if @message.save
      render :show, status: 201
      @message_number = @session.messages.length
      set_locale
      set_reply
    else
      render json: { code: 422, message: "Unfortunately we don't have support for your language yet." }, status: 422
    end
  end

  def show
    unless Session.exists?(identifier: params[:session_id]) && Message.exists?(identifier: params[:id])
      render json: { code: 404, message: "Resource doesn't exist" }, status: 404
    end
  end

  private

  def set_message
    @message = Message.find_by(identifier: params[:id])
  end

  def set_locale
      I18n.locale = @message.detected_language if @message_number == 2
  end

  def set_reply
    @reply = Reply.new(session: @session, message: I18n.t(@message_number), reply_to: @message.identifier, shortname: "Reply ##{@message_number}", language: I18n.locale)
    @reply.save
  end

end

