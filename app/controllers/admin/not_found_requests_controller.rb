class Admin::NotFoundRequestsController < ApplicationController
  def destroy_all
    NotFoundRequest.destroy_all
    NotFoundRequest.reset_at = Time.now
    flash[:message] = "All requests have been deleted."
    redirect_to dashboard_path
  end
end