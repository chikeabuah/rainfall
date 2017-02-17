json.extract! session, :id, :current_status, :experience_years, :cs_major, :alternative_language, :created_at, :updated_at
json.url session_url(session, format: :json)