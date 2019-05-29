macOS
================

#### keyboard shortcuts

##### general

| shortcut          | action                                    |
| ----------------- | ----------------------------------------- |
| CMD + Tab         | display open apps (+Tab to scroll right)  |
| CMD + Tab + SHIFT | display open apps (+Tab to scroll left)   |
| CMD + Comma       | open app preferences                      |
| CMD + Spacebar    | spotlight                                 |
| CMD + Q           | quit app                                  |
| CMD + W           | close window (e.g. closes tab in RStudio) |
| CTRL + LEFTARROW  | scroll between desktops left              |
| CTRL + RIGHTARROW | scroll between desktops right             |
| CTRL + UPARROW    | toggle mission control                    |

##### screen shots

| shortcut                   | action                                 |
| -------------------------- | -------------------------------------- |
| CMD + SHIFT + 3            | take a screenshot of the entire screen |
| CMD + SHIFT + 4            | take a screenshot using a crosshair    |
| CMD + SHIFT + 4 then SPACE | take a screenshot by clicking a window |

##### finder

| shortcut        | action                          |
| --------------- | ------------------------------- |
| CMD + T         | open new tab                    |
| CMD + Y         | open preview                    |
| CMD + SHIFT + A | open Applications folder        |
| CMD + SHIFT + D | open Desktop folder             |
| CMD + SHIFT + U | open Utilities folder           |
| CMD + SHIFT + . | toggle hide/unhide hidden files |

##### terminal

| shortcut                        | action                     |
| ------------------------------- | -------------------------- |
| Tab                             | auto-complete              |
| CTRL + A (also FN + LEFTARROW)  | go to beginning of line    |
| CTRL + E (also FN + RIGTHARROW) | go to end of line          |
| CTRL + C                        | cancel whatever is running |
| CTRL + L                        | clear screen               |
| CTRL + Q                        | clear line                 |

-----

#### command line

``` sh
# unhide a file/folder
chflags nohidden PATH

# hide a file/folder
chflags hidden PATH
```
