#!/bin/bash

tmux new -s "TestSession" -n First -d
tmux neww -n "Fenêtre2"
tmux selectw -t 1
tmux splitw -v
sleep 2
tmux send-keys -t "TestSession:First.1" 'echo "Première fenêtre - Premier panneau"' Enter
tmux send-keys -t "TestSession:Fenêtre2.1" 'echo "Seconde fenêtre - Premier panneau"' Enter
tmux send-keys -t "TestSession:First.2" 'echo "Première fenêtre - Second panneau"' Enter
tmux attach-session -t "TestSession" -d

