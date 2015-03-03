class HomeController < ApplicationController
    attr_accessor :x, :y
    attr_accessor :counter


  # https://developer.linkedin.com/documents/profile-fields
  def submit_linkedin_resume
      #  if Rails.env.production?
      # host = "https://www.jobline.com.sg"
      # elsif Rails.env.development?
      # host = "http://192.168.1.10:3000/"
      #elsif Rails.env.staging?
      #host = "http://58.185.193.188:6060"
      #end
      host = "http://127.0.0.1:3000"

    url = "#{host}/submit_linkedin_resume_cb"
    client = LinkedIn::Client.new(LINKEDIN_API_KEY, LINKEDIN_SECRET_KEY)
    request_token = client.request_token({oauth_callback: url})

    rtoken = request_token.token
    rsecret = request_token.secret

    # Save it to session because need to reconstruct at the callback
    session[:rtoken] = rtoken
    session[:rsecret] = rsecret
    # x = rtoken
    # y = rsecret
    # puts 'ni hao '
    # puts x
    # puts y
    # puts session[:rtoken]
    # puts 'helllo world'
    redirect_to request_token.authorize_url
  end
  
  def submit_linkedin_resume_cb
      
      #redirect_to "http://www.google.com
      client = LinkedIn::Client.new(LINKEDIN_API_KEY, LINKEDIN_SECRET_KEY)
      # if session[:rtoken].nil?
      #puts 'hello friend'
      #else
      #puts 'ni hao ma, wo hen hao. ni ne? apa khabaar'
      #end
      if session[:atoken].nil?
          pin = params[:oauth_verifier]
          atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
          puts 'ni hao '
          puts x
          puts y
          # atoken, asecret = client.authorize_from_request(x, y, pin)
          session[:atoken] = atoken
          session[:asecret] = asecret
          else
          redirect_to "http://www.google.com"
      end
    end
end
