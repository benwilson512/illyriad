# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_illyriad_session',
  :secret      => '21cec7dd9dfb4008f7ebeb11651a99634bff0f09a76bf0e1cb4b8173d2a15fb7601a8fdce47cbf29063b7260d7367fe2a3a43d97036a050c340d444a6f5c5fd1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
