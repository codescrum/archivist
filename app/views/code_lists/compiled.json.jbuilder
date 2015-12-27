json.array!(@code_lists) do |code_list|
  json.extract! code_list, :id, :label
  json.response_domain code_list.is_response_domain?
  json.codes code_list.codes do |code|
    json.val code.value
    json.label code.label
  end
end
