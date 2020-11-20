
set -e
set -x

# install devtools
install_languages() {

  sudo apt update

  # Install nodeJS and yarn
  curl -o ~/.nvm/nvm.sh https://raw.githubusercontent.com/creationix/nvm/v0.31.0/nvm.sh
  bash -c "nvm use node" || true
  bash -c "source ~/.nvm/nvm.sh; nvm install node; node --version"

  # Install swift
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
  node -v

  nvm alias default node
  nvm use default
}

install_formatters() {
  # installing swift formatter
  git clone --depth 1 --branch 0.47.4 https://github.com/nicklockwood/SwiftFormat.git
  cd SwiftFormat
  swift build -c release
  sudo cp .build/release/swiftformat /usr/local/bin/swiftformat
  cd ..

  which yarn
  which node
  yarn -v
  node -v

  yarn install
  pip install pylint
}

install_languages
export PATH="~/swift/swift/usr/bin:$PATH"
install_formatters