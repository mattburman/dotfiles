alias jqc='jq -c'

jq-keys() {
  jq 'keys'
}

jqk() {
  jq 'keys'
}

jq-flatten() {
  jq 'flatten'
}

jq-result() {
  jq -c '.result[]'
}

jq-c-result() {
  jq-result
}

jq-l() {
  jq -c '.[]'
}
