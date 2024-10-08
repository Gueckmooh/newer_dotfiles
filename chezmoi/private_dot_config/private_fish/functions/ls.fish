function ls --wraps='eza --git --color=auto -F' --description 'alias ls=eza --git --color=auto -F'
  eza --git --color=auto -F $argv
  or command ls --color=auto $argv
        
end
