json.array!(@api_call_logs) do |api_call_log|
  json.extract! api_call_log, :id, :call_description, :call_date_time, :successful, :end_point_path, :twitter_handle, :records_inserted
  json.url api_call_log_url(api_call_log, format: :json)
end
