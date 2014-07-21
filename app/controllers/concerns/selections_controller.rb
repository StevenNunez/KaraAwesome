class SelectionsController < ApplicationController
  def destroy
    Selection.find_by(id: params[:id]).destroy
    render nothing: true
  end
end
