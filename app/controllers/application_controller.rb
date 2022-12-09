class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound,   with: :render_404
end

def render_404
  render(  json: {:error => "Record not found"},   status: 404)
end
