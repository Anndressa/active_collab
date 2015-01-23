require 'active_collab/user'

module ActiveCollab
	module API
		module Users

		  def user_info
		    url = "#{@api_url}?auth_api_token=#{@api_key}&path_info=info&format=json"
		    response = HTTParty.get(url)
		    response.code == 200 ? ActiveCollab::User.from_info(JSON.parse(response.body)["logged_user"]) : response.body
		  end

		  def authenticate(email,password,client_name,client_vendor)
		  	body = {
		  		'api_subscription[email]'					=> email,
					'api_subscription[password]'			=> password,
					'api_subscription[client_name]' 	=> client_name,
					'api_subscription[client_vendor]' => client_vendor
				}
		    response = HTTParty.post @api_url, body: body
		    response.code == 200 ? @api_key = response.body.split(':')[1].strip : response.body
		  end

		  def users_by_company(company_id)
		  	url = "#{@api_url}?auth_api_token=#{@api_key}&path_info=/people/#{company_id}&format=json"
		    response = HTTParty.get(url)
		    if response.code == 200 
		    	response_json = JSON.parse(response.body)
		    	users = []
		    	response_json['users'].each do |user|
		    		users << ActiveCollab::User.from_info(user) 
		    	end
		    else
		    	response.body
		    end
		  end
		end
	end

end