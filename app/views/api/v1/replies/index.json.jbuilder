json.array! @replies do |reply|
  json.extract! reply, :message, :shortname, :reply_to, :created_at, :language
end
