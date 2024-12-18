# jenv

```sh
# install java versions
brew tap adoptopenjdk/openjdk
brew search adoptopenjdk
brew install adoptopenjdk8
brew install adoptopenjdk11

# list installed versions
ls -1 /Library/Java/JavaVirtualMachines

# list home directories
echo $(/usr/libexec/java_home) # system version
echo $(/usr/libexec/java_home -v 1.8)  # v 8
echo $(/usr/libexec/java_home -v 11)

# install jenv
brew install jenv
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc
source ~/.zshrc
jenv enable-plugin export
jenv doctor

# add java versions to jenv
jenv add $(/usr/libexec/java_home -v 1.8)
jenv add $(/usr/libexec/java_home -v 11)
jenv versions

# switch between versions
cd ~
jenv global 1.8
java -version

mkdir -p ~/temp
cd ~/temp
jenv local 11.0
cat .java-version
java -version

cd ~
java -version

cd ~/temp
java -version
```