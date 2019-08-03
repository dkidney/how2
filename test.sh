# list existing screens
screen -ls

# start a new screen and give it a name
screen -S test-screen

# start a new screen and give it a name - or attach to exisitng session with that name
screen -R test-screen

# start a new terminal window within the screen session
screen -t test-window1
screen -t test-window2
screen -t test-window3

# detach the screen
screen -d

# re-attach the screen
screen -r test-screen

# kill the screen/window
exit

