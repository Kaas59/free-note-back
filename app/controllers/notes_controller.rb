module V0
  class NotesController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_v0_user!, only: [:index, :show, :update, :destroy]
    before_action :set_note, only: [:show, :update, :destroy]

    # GET /notes
    def index
      # @notes = Note.all
      # @note_list = Note.all
      # @notes = Kaminari.paginate_array(@note_list).page(@pages).per(2)
      @notes = Note.where(user_id: current_v0_user[:id].to_i).all
      render json: @notes
    end

    # GET /notes/1
    def show
      render json: @note
    end

    # POST /notes
    def create
      @note = Note.new(note_params)
      @note.user_id = current_v0_user[:id].to_i

      if @note.save
        render json: @note, status: :created
      else
        render json: @note.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /notes/1
    def update
      if @note.update(note_params)
        render json: @note
      else
        render json: @note.errors, status: :unprocessable_entity
      end
    end

    # DELETE /notes/1
    def destroy
      @note.destroy
    end

    def preview
      @note = Note.where(id: params[:id], share_flag: 1, share_pass: params[:pass])
      if @note.present?
        render json: @note
      else
        render json: {error: '404 Not Found'}, status: 404
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_note
        @note = Note.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def note_params
        params.require(:note).permit(:user_id, :text, :share_flag, :share_pass)
      end
  end
end
