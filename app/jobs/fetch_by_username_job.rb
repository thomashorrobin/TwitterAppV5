class FetchByUsernameJob < ActiveJob::Base
  queue_as :twitter_api

  def perform(*args)
    add_user_account(args[0])
  end
  
  def add_user_account (username)
      # Now you will fetch /1.1/statuses/user_timeline.json,
      # returns a list of public Tweets from the specified
      # account.
      baseurl = "https://api.twitter.com"
      path    = "/1.1/users/show.json"
      # path    = "/1.1/followers/list.json"
      query   = URI.encode_www_form(
          "screen_name" => username,
          "count" => 200,
      )
      address = URI("#{baseurl}#{path}?#{query}")

      # Set up HTTP.
      http             = Net::HTTP.new address.host, address.port
      http.use_ssl     = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      # If you entered your credentials in the previous
      # exercise, no need to enter them again here. The
      # ||= operator will only assign these values if
      # they are not already set.
      consumer_key ||= OAuth::Consumer.new("81lKqVQwhRmmpRUk6FWvhFvF4", "cWQxoI1B9WFOPHTNTXc64zn0oOGvswpktbYeH1xqUIbjqr1EYc")
      access_token ||= OAuth::Token.new("33718717-CHcZAacLIT07lkrsb0uKxxbPFr3SFKXOqCavXKVz6", "rhHjSc3Rpk2Fl3DrgGOR5T7PfRExa9FaBs3hu0jAkLG7z")

      # Issue the request.
      request = Net::HTTP::Get.new address.request_uri
      request.oauth! http, consumer_key, access_token
      http.start
      response = http.request(request)

      i = JSON.parse(response.body)

      @twitter_account = Account.new

      @twitter_account.username = i['screen_name']
      @twitter_account.display_name = i['name']
      @twitter_account.twitter_id = i['id_str']
      @twitter_account.followers_count = i['followers_count']
      @twitter_account.following_count = i['friends_count']

      @twitter_account.save

      http.finish
      
      write_to_api_call_log("Called the users/show end point to retrive data on " + username, true, '/users/show', username, 1)

      FetchFollowersJob.perform_later i['id_str']
      FetchFollowingJob.perform_later i['id_str']
    end
  
  def write_to_api_call_log (message, successful, path, handle, records_inserted)
      
      @api_call_log = ApiCallLog.new
      
      @api_call_log.call_date_time = Time.new
      @api_call_log.call_description = message
      @api_call_log.successful = successful
      @api_call_log.end_point_path = path
      @api_call_log.twitter_handle = handle
      @api_call_log.records_inserted = records_inserted
      
      @api_call_log.save
      
    end
end
