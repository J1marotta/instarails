class ProfilesController < ApplicationController
  # set profile before_action
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    # there either is a profile page
    redirect_to edit_profile_url if @profile.nil?
    # or there isn't
  end

  def new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user

    respond_to do |format|
      if @profile.save
        format.html { redirect_to profile_path, notice: 'Photo was successfully created.' }

      else
        format.html { redirect_to edit_profile_path, notice: "There was an error, profile couldn't save" }

      end
    end
  end

  def edit
    # find the profile by the current user or create it if it doesn't exist... handy ruby built in function
    @profile = Profile.find_or_initialize(user: current_user)
  end

  def update
  respond_to do |format|
    # Are they pushing the follow button?
    if performing_follow?
      @profile.user.toggle_followed_by(current_user)
      format.html { redirect_to @profile.user}
      # are they updating their profile.
    elsif @profile.update(profile_params)
      format.html { redirect_to profile_path, notice: 'Photo was successfully created.' }
    else
        format.html { redirect_to edit_profile_path, notice: "There was an error, profile couldn't save" }
    end
    end
  end

  def destroy
  end



  private

  #  set profile function to stop you ending up at the your own profile
  def set_profile
    if params[:id]
      # If there are params it is not the curent user
      @profile = Profile.find_by(user_id: params[:id])
    else
      # Must be the owner if no params
      @profile = Profile.find_by(user: current_user)
    end
  end


  def profile_params
    params.require(:profile).permit(:username, :first_name, :last_name, :bio)
  end

  def performing_follow?
    params.require(:user)[:toggle_follow].present?
  end



end
