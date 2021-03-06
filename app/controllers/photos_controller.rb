class PhotosController < ApplicationController

  before_action :set_photo, only: [:upvote, :downvote, :show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.order("created_at desc")
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # new methods to allow likeing and dislikes

  def upvote
    @photo.upvote_by current_user
    redirect_to :root

  end

  def downvote
    @photo.downvote_by current_user
    redirect_to :root
  end


  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user  #devise method for current user

    respond_to do |format|
      if @photo.save
        format.html { redirect_to photo_comments_path(@photo), notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if is_liking?
        # Toggle whether this photo is liked by the current user
        @photo.toggle_liked_by(current_user)
        format.html { redirect_to photos_path }
      elsif @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image, :caption, :image_data)
    end

    def is_liking?
      #  is there a liked field in the form (our hidden field)
      # Same as following , there is a toggle button that has a param of liked turn it on and off and toggle the join table.
      params.require(:photo)[:liked].present?
    end

end
