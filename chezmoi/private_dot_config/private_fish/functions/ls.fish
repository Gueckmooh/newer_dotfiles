function ls --wraps='eza --git --color=auto -F' --description 'alias ls=eza --git --color=auto -F'
  eza --git --color=auto -F $argv
        
end
