# #!/usr/bin/ruby

# require 'rubygems'
# require 'google/api_client'
# # The oauth/oauth_util code is not part of the official Ruby client library.
# # Download it from:
# # http://samples.google-api-ruby-client.googlecode.com/git/oauth/oauth_util.rb
# require 'oauth/oauth_util'


# # This OAuth 2.0 access scope allows for full read/write access to the
# # authenticated user's account.
# YOUTUBE_SCOPE = 'https://www.googleapis.com/auth/youtube'
# YOUTUBE_API_SERVICE_NAME = 'youtube'
# YOUTUBE_API_VERSION = 'v3'

# client = Google::APIClient.new
# youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

# auth_util = CommandLineOAuthHelper.new(YOUTUBE_SCOPE)
# client.authorization = auth_util.authorize()

# body = {
#   :snippet => {
#     :resourceId => {
#       :kind => 'youtube#channel',
#       # Replace the value below with the ID of the channel being subscribed to.
#       :channelId => 'UCtVd0c0tGXuTSbU5d8cSBUg'
#     }
#   }
# }

# # Call the API's youtube.subscriptions.insert method to add the subscription
# # to the specified channel.
# begin
#   subscriptions_response = client.execute!(
#     :api_method => youtube.subscriptions.insert,
#     :parameters => {
#       :part => body.keys.join(',')
#     },
#     :body_object => body
#   )
#   puts "A subscription to '#{subscriptions_response.data.snippet.title}' was added."
# rescue Google::APIClient::ClientError => e
#   puts "#{e}: Unable to add subscription. Are you already subscribed?"
# end
# Upload a video

# # The code sample below calls the API's videos.insert method to upload a video to the channel associated with the request.

# #!/usr/bin/ruby

# require 'rubygems'
# require 'google/api_client'
# # The oauth/oauth_util code is not part of the official Ruby client library.
# # Download it from:
# # http://samples.google-api-ruby-client.googlecode.com/git/oauth/oauth_util.rb
# require 'oauth/oauth_util'
# require 'trollop'


# # This OAuth 2.0 access scope allows an application to upload files to the
# # authenticated user's YouTube channel, but doesn't allow other types of access.
# YOUTUBE_READ_WRITE_SCOPE = 'https://www.googleapis.com/auth/youtube.upload'
# YOUTUBE_API_SERVICE_NAME = 'youtube'
# YOUTUBE_API_VERSION = 'v3'

# client = Google::APIClient.new(:application_name => $0, :application_version => '1.0')
# youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

# auth_util = CommandLineOAuthHelper.new(YOUTUBE_READ_WRITE_SCOPE)
# client.authorization = auth_util.authorize()

# opts = Trollop::options do
#   opt :file, 'Video file to upload', :type => String
#   opt :title, 'Video title', :default => 'Test Title', :type => String
#   opt :description, 'Video description',
#         :default => 'Test Description', :type => String
#   opt :categoryId, 'Numeric video category. See https://developers.google.com/youtube/v3/docs/videoCategories/list',
#         :default => 22, :type => :int
#   opt :keywords, 'Video keywords, comma-separated',
#         :default => '', :type => String
#   opt :privacyStatus, 'Video privacy status: public, private, or unlisted',
#         :default => 'public', :type => String
# end

# if opts[:file].nil? or not File.file?(opts[:file])
#   Trollop::die :file, 'does not exist'
# end

# body = {
#   :snippet => {
#     :title => opts[:title],
#     :description => opts[:description],
#     :tags => opts[:keywords].split(','),
#     :categoryId => opts[:categoryId],
#   },
#   :status => {
#     :privacyStatus => opts[:privacyStatus]
#   }
# }

# # Call the API's videos.insert method to create and upload the video.
# videos_insert_response = client.execute!(
#   :api_method => youtube.videos.insert,
#   :body_object => body,
#   :media => Google::APIClient::UploadIO.new(opts[:file], 'video/*'),
#   :parameters => {
#     'uploadType' => 'multipart',
#     :part => body.keys.join(',')
#   }
# )

# puts "'#{videos_insert_response.data.snippet.title}' (video id: #{videos_insert_response.data.id}) was successfully uploaded."
# # Except as otherwise noted, the content of this page is licensed under the Creative Commons Attribution 3.0 License, and code samples are licensed under the Apache 2.0 License. For details, see our Site Policies.

# # Last updated February 7, 2014.
