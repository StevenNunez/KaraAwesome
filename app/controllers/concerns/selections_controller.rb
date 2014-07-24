class SelectionsController < ApplicationController
  def destroy
    selection = current_user.selections.find_by(id: params[:id])
    selection.destroy if selection

    render nothing: true
  end
end
