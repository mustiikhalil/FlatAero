
set -e
set -x

# install devtools
install_languages() {

  sudo apt update

  wget https://raw.githubusercontent.com/creationix/nvm/v0.31.0/nvm.sh -O ~/.nvm/nvm.sh
  source ~/.nvm/nvm.sh
  nvm install node
  node --version
  curl -o- -L https://yarnpkg.com/install.sh | bash
  export PATH="$HOME/.yarn/bin:$PATH"
  yarn config set prefix ~/.yarn -g
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

  # install swift
  sudo apt-get install \
          binutils \
          git \
          libc6-dev \
          libcurl3 \
          libedit2 \
          libgcc-5-dev \
          libpython2.7 \
          libsqlite3-0 \
          libstdc++-5-dev \
          libxml2 \
          pkg-config \
          tzdata \
          zlib1g-dev

  SWIFT_URL=https://swift.org/builds/swift-5.3.1-release/ubuntu1604/swift-5.3.1-RELEASE/swift-5.3.1-RELEASE-ubuntu16.04.tar.gz
  curl -fSsL "$SWIFT_URL" -o swift.tar.gz

  mkdir ~/swiftbuild
  tar -xvzf swift.tar.gz -C ~/swiftbuild

  export PATH="~/swiftbuild/swift-5.3.1-RELEASE-ubuntu16.04/usr/bin:$PATH"

  swift --version

  yarn -v
}

install_formatters() {
  # installing swift formatter
  git clone --depth 1 --branch 0.47.4 https://github.com/nicklockwood/SwiftFormat.git
  cd SwiftFormat
  swift build -c release
  sudo cp .build/release/swiftformat /usr/local/bin/swiftformat
  cd ..

  which yarn
  yarn -v
  node -v

  # Install required formatters
  sudo yarn global add eslint --prefix /usr/local

  yarn i
  pip install pylint
}

install_languages
export PATH="~/swift/swift/usr/bin:$PATH"
install_formatters