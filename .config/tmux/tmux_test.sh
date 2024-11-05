#!/bin/bash

tmux new -s "ROSS" -n Interfaces -d
tmux splitw -v
tmux selectp -t "ROSS:Interfaces.1"
tmux splitw -h
tmux splitw -h
tmux selectp -t "ROSS:Interfaces.4"
tmux splitw -h
sleep 2
# tmux send-keys -t "ROSS:Interfaces.1" 'echo "Première fenêtre - 1er panneau"' Enter
tmux send-keys -t "ROSS:Interfaces.1" '~/ross_interfaces/gpross.expect' Enter
tmux send-keys -t "ROSS:Interfaces.2" '~/ross_interfaces/chross.expect' Enter
tmux send-keys -t "ROSS:Interfaces.3" '~/ross_interfaces/chshross.expect' Enter
tmux send-keys -t "ROSS:Interfaces.4" '~/ross_interfaces/telegram_roll.expect' Enter
tmux send-keys -t "ROSS:Interfaces.5" '~/ross_interfaces/telegram_sheet.expect' Enter
tmux attach-session -t "ROSS" -d

