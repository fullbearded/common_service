if @result.present?
  json.ret 1
  json.response @result
  json.total @result.size
  if params[:filter]
    json.content = @content
  end
else
  json.ret 0
end
