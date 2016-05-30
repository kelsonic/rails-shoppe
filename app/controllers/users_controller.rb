class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)
    if @user.save
      client = SendGrid::Client.new do |c|
        c.api_key = ENV["SENDGRID_SECRET_KEY"]
      end

      session[:user_id] = @user.id
      flash[:success] = "User was created successfully."
      mail = SendGrid::Mail.new do |m|
        m.to = @user.email
        m.from = 'taco@cat.limo'
        m.subject = 'Hello world!'
        m.text = 'I heard you like pineapple.'
      end
      res = client.send(mail)
      puts res.code
      puts res.body
      redirect_to root_path
    else
      flash[:errors] = @user.errors.full_messages
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

end
