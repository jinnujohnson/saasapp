class ContactsController < ApplicationController
  
  # GET request to /contact-us
  # Show new contact form
  def new
  @contact = Contact.new
  end
  
  # POST request to /contacts
  def create
  # Mass assignments of contact fields into Contact object 
    @contact = Contact.new(contact_params)
  # Save Contact object to database
    if @contact.save
  # Store form fields via parameters into variables 
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
  # Plug variables into ContactMailer email method and send email
      ContactMailer.contact_email(name,email,body).deliver
  # Store success message to flash hash and redirects to new action
      flash[:success] = "Message sent."
       redirect_to new_contact_path
    else
  # If Contact objest doesn't save, store errors in flash hash
      flash[:danger] = @contact.errors.full_messages.join(", ")
       redirect_to new_contact_path
    end
  end
  
  # To collect data from contact form, we need to use strong parameters
  # and whitelist the formfields
  private
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
      
    
end