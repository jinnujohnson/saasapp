class ProfilesController < ApplicationController

# GET request to /users/:user_id/profile/new
  def new
    # Render blank profile form
    @profile = Profile.new
  end
  
  def create
    # Ensure that we have user who is filling out the form
    @user = User.find( params[:user_id] )
    # Create profile is linked to this specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end
  
  def edit
    # GET request to /users/:user_id/profile/edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  
private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
  end
    
end