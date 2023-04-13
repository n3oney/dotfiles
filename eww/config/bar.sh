#!/usr/bin/env fish

set lastws 2

function handle
  if string match -q "workspace>>?" $argv[1]
      set ws $(string sub -s 12 $argv[1])

      set lastws $ws

      set wincount $(hyprctl workspaces -j | jq -r ".[] | select (.id == $ws).windows")

      if test $wincount -eq 1
          echo "nogaps"
      else
          echo ""
      end
  end

  if test -n $lastws

    if string match -q "changefloatingmode>>*" $argv[1]
      or string match -q "movewindow>>*" $argv[1]
      or string match -q "openwindow>>*" $argv[1]
      or string match -q "closewindow>>*" $argv[1]
  
        set wincount $(hyprctl workspaces -j | jq -r ".[] | select (.id == $lastws).windows")

        if test $wincount -eq 1
            echo "nogaps"
        else
            echo ""
        end
    end
  end
end

socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read line; handle $line; end