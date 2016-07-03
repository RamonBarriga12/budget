require 'forwardable'

module Budget
	class GoogleApi

		extend Forwardable

		def_delegators :@service, :list_events

		OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
		APPLICATION_NAME = 'Google Calendar API Ruby Quickstart'
		CLIENT_SECRETS_PATH = 'client_id.json'
		CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
		                             "calendar-ruby-quickstart.yaml")
		SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY

		def initialize
			@service = Google::Apis::CalendarV3::CalendarService.new
			@service.client_options.application_name = APPLICATION_NAME
			@service.authorization = authorize
		end

		def authorize
		  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

		  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
		  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
		  authorizer = Google::Auth::UserAuthorizer.new(
		    client_id, SCOPE, token_store)
		  user_id = 'default'
		  credentials = authorizer.get_credentials(user_id)
		  if credentials.nil?
		    url = authorizer.get_authorization_url(
		      base_url: OOB_URI)
		    puts "Open the following URL in the browser and enter the " +
		         "resulting code after authorization"
		    puts url
		    code = gets
		    credentials = authorizer.get_and_store_credentials_from_code(
		      user_id: user_id, code: code, base_url: OOB_URI)
		  end
		  credentials
		end

	end
end