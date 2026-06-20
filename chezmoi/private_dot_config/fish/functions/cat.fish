function cat --wraps=batcat --description 'alias cat=batcat'
  if which bat 2>&1 >/dev/null
    command bat $argv
  else
    command batcat $argv
  end
end
