class ProfilesController < ApplicationController

  def index
  end

  def show
    #  goto the current user profile page
    @profile = Profile.find_by(user: current_user)

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
    @profile = Profile.find_by(user: current_user)
    @profile = Profile.new(user: current_user) if @profile.nil?
  end

  def update
  end

  def destroy
  end



  private

  def profile_params
    params.require(:profile).permit(:username, :first_name, :last_name, :bio)
  end



end
