function tree --wraps='eza --color=auto -T' --description 'alias tree eza --color=auto -T'
  eza --color=auto -T $argv
  or tree $argv
        
end
