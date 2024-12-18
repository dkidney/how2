# xcode

## install command line tools

```sh
xcode-select --install # also installs git

# accept licence
sudo xcodebuild -license accept

# verify that you’ve successfully installed it
xcode-select -p 

# check version
xcode-select --version

# check gcc version
gcc --version 
```

### update

```sh
sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install
```

### install using mas

```sh
mas search Xcode

mas install 497799835 # Xcode (10.3)
```
