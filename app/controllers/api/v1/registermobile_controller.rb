class Api::V1::RegistermobileController  < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    email = params[:email]
    password = params[:password]
    if request.format != :json
      render :status=>406, :json=>{:message=>"The request must be json"}
      return
    end

    if email.nil? or password.nil?
      render :status=>400,
             :json=>{:message=>"The request must contain the user email and password."}
      return
    end

    @user=User.find_by_email(email.downcase)

    if !@user.nil?
      logger.info("User #{email} failed signin, user cannot be found.")
      render :status=>401, :json=>{:message=>"Email already used"}
      return
    end

    # http://rdoc.info/github/plataformatec/devise/master/Devise/Models/TokenAuthenticatable

    a=User.new
    a.email = email
    a.password = password
    a.password_confirmation = password
    a.save
    if !a.valid?
      render :status =>200, :json=>{:message=>a.errors.to_s}
    else
      render :status =>200, :json=>{:message=>"OK"}

    end

  end

end
