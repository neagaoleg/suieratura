# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sm_session',
  :secret      => '606c0726f75cf76c775c44e7dce65814863ed52afd68a9a785f6d42d8e7a25ed9151f2c4c2627dec3d6d72a40034f3a5e8fd0181d6c6273dc667d577f17d307b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
