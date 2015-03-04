class HomeController < ApplicationController

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
    redirect_to request_token.authorize_url
  end
  
  def submit_linkedin_resume_cb

      #redirect_to "http://www.google.com
      client = LinkedIn::Client.new(LINKEDIN_API_KEY, LINKEDIN_SECRET_KEY)
      if session[:atoken].nil?
          pin = params[:oauth_verifier]
          atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
          session[:atoken] = atoken
          session[:asecret] = asecret
      else
          redirect_to "http://www.google.com"
      end
      
      profile = client.profile(fields: %w(
                                           summary
                                           email_address
                                           first-name
                                           last-name
                                           date-of-birth
                                           phone-numbers
                                           main-address
                                           positions
                                           educations
                                           location
                                           industry
                                           interests
                                           languages
                                           skills
                                           specialties
                                        ))
      #TODO: Make it more efficient!
      session[:summary] = profile.summary
      session[:email] = profile.email_address
      session[:first] = profile.first_name
      session[:last] = profile.last_name
      session[:birth] = profile.date_of_birth
      session[:phone] = profile.phone_numbers
      session[:address] = profile.main_address
      session[:position] = profile.positions
      session[:edu] = profile.educations
      session[:location] = profile.location
      session[:industry] = profile.industry
      session[:interest] = profile.interests
      session[:languages] = profile.languages
      session[:skill] = profile.skills
      session[:special] = profile.specialties
      
      session[:atoken] = nil
      session[:asecret] = nil
      redirect_to resume_sent_path

   end
  
    def resume_sent
        @summary = session[:summary]
        @email = session[:email]
        @first =session[:first]
        @last = session[:last]
        @birth = session[:birth]
        @phone = session[:phone].phone_number
        @address = session[:address]
        @position = session[:position].title
        @edu = session[:edu].degree
        @location = session[:location].name
        @industry = session[:industry]
        @interest = session[:interest]
        @languages = session[:languages]
        @skill = session[:skill]
        @special = session[:special]

    end
  
end
