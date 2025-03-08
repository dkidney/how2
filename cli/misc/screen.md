## screen

http://aperiodic.net/screen/quick_reference  
https://opensource.com/article/17/3/introduction-gnu-screen  
http://www.kinnetica.com/2011/05/29/using-screen-on-mac-os-x  

* useful for managing long-running processes
* can close terminal window or break SSH connection without interrupting the processes
* can have multiple terminal windows within each screen session

```sh
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

# kill the attached screen/window 
exit

# kill a detached screen
screen -XS test-screen quit
```

`Ctrl-a ?` help  
`Ctrl-a H` activate screen logging (creates log file `screenlog.0`)  

Terminal windows:

`Ctrl-a i` view which window you are currently using  
`Ctrl-a n` go to the next window
`Ctrl-a p` go to the previous window  

Split panes:

`Ctrl-a S` make a new pane  
`Ctrl-a Q` quit the split pane mode  
`Ctrl-a Tab` switch between panes


