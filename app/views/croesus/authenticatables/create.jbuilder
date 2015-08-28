json.set! @authenticatable.class.name.underscore.to_sym, @authenticatable
json.local_credential do
  json.username @authenticatable.local_credential.username
end
json.session do
  json.token @authenticatable.sessions.last.token
end