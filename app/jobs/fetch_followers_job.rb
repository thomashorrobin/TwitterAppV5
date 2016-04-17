class FetchFollowersJob < ActiveJob::Base
  queue_as :twitter_api

  def perform(*args)
    # Do something later
    add_followers(args[0])
  end
  
  
    def add_followers (twitter_id)
      # Now you will fetch /1.1/statuses/user_timeline.json,
      # returns a list of public Tweets from the specified
      # account.
      baseurl = "https://api.twitter.com"
      path    = "/1.1/followers/ids.json"
      # path    = "/1.1/followers/list.json"

      # If you entered your credentials in the previous
      # exercise, no need to enter them again here. The
      # ||= operator will only assign these values if
      # they are not already set.
      consumer_key ||= OAuth::Consumer.new("81lKqVQwhRmmpRUk6FWvhFvF4", "cWQxoI1B9WFOPHTNTXc64zn0oOGvswpktbYeH1xqUIbjqr1EYc")
      access_token ||= OAuth::Token.new("33718717-CHcZAacLIT07lkrsb0uKxxbPFr3SFKXOqCavXKVz6", "rhHjSc3Rpk2Fl3DrgGOR5T7PfRExa9FaBs3hu0jAkLG7z")

      cursor = -1

      loop do

        query   = URI.encode_www_form(
            "user_id" => twitter_id,
            "count" => 5000,
            "cursor" => cursor
        )
        address = URI("#{baseurl}#{path}?#{query}")

        logger.debug address

        # Set up HTTP.
        http             = Net::HTTP.new address.host, address.port
        http.use_ssl     = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER

        # Issue the request.
        request = Net::HTTP::Get.new address.request_uri
        request.oauth! http, consumer_key, access_token
        http.start
        response = http.request(request)

        i = JSON.parse(response.body)

        if i['errors'] != nil
            write_to_api_call_log("A rate limit was hit when processing for twitter id: " + twitter_id, false, '/followers/list', twitter_id, 0)
            sleep 15 * 60
            break
        end

        i['ids'].each do |id|

            @twitter_relationship = TwitterRelationship.new

            @twitter_relationship.follower = id
            @twitter_relationship.followed = twitter_id

            @twitter_relationship.save

        end

        cursor = i['next_cursor']

        http.finish
        
        write_to_api_call_log("Following data was successfully retrived for twitter id: " + twitter_id, true, '/followers/ids', twitter_id, i['ids'].count)

        break if cursor == 0

      end
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
