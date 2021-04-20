class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: :new

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash[:notice] = "Gracias por su mensaje nos contactaremos a la brevedad!"
      redirect_to root_path
    else
      render :new
    end
  end
end
