json.id :id
json.label :label
json.codes @code_list.codes do |code|
  json.val code.value
  json.label code.label
end
