class Api::V1::RepliesController < Api::V1::BaseController

  def create
  end

  def index
    unless Session.exists?(identifier: params[:session_id])
      render json:{code: 404, message: "Resource doesn't exist"}, status: 404
    else
      @replies = Session.find_by(identifier: params[:session_id]).replies
    end

  end

end

