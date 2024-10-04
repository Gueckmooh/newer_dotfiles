#!/usr/bin/env fish

function __dotdotdot__
    set -l length (math (string length -- $argv) - 1)
    echo (string repeat -n $length ../)
end

abbr --add dotdotdot --regex '\.\.+' --position anywhere --function __dotdotdot__
