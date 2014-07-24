class SelectionsController < ApplicationController
  def destroy
    selection = current_user.selections.find_by(id: params[:id])
    if selection
      selection.destroy
      render json: selection.id
    else
      render nothing: true
    end
  end
end
