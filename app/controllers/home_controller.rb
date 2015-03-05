class HomeController < ApplicationController
    
  # https://developer.linkedin.com/documents/profile-fields
  def submit_linkedin_resume
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
                                          picture-url
                                          public-profile-url
                                          last-modified-timestamp
                                        ))
    session[:profile] = profile
    session[:atoken] = nil
    session[:asecret] = nil
    redirect_to resume_sent_path
  end
  
  def resume_sent
    @profile = session[:profile]
  end

end
