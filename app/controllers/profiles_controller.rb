class ProfilesController < ApplicationController

# GET request to /users/:user_id/profile/new
  def new
    # Render blank profile form
    @profiles = Profile.new
  end
  
  def create
    # Ensure that we have user who is filling out the form
    @user = User.find( params[:user_id] )
    # Create profile is linked to this specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to root_path
    else
      render action: :new
    end
  end
  
private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
  end
    
end