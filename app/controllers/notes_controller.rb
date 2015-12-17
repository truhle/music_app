class NotesController < ApplicationController

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.save
    @track = Track.find(params[:track_id])
    redirect_to @track
  end

  def destroy
    @note = find_note
    @track = Track.find(@note.track_id)
    if !current_user.admin? || current_user.id != @note.user_id
      render text: "403 FORBIDDEN"
    else
      @note.destroy
      redirect_to @track
    end
  end

  def show
    @note = find_note
  end

private

  def find_note
    Note.find(params[:id])
  end

  def note_params
    params.permit(:content, :track_id)
  end
end
