#/bin/bash -e

VERSION=`curl -s -L https://api.github.com/repos/yudai/gotty/releases/latest | jq -r .tag_name`

SHASUMS=`curl -s -L "https://github.com/yudai/gotty/releases/download/${VERSION}/SHASUMS"`

DARWIN_ASSET_NAME="gotty_darwin_amd64.tar.gz"
LINUX_ASSET_NAME="gotty_linux_amd64.tar.gz"

SHA1_DARWIN=`echo "${SHASUMS}" | grep ${DARWIN_ASSET_NAME} | cut -f 1 -d ' '`
SHA1_LINUX=`echo "${SHASUMS}" | grep ${LINUX_ASSET_NAME} | cut -f 1 -d ' '`

echo "VERSION: ${VERSION}"
echo "SHA1 DARWIN: ${SHA1_DARWIN}"
echo "SHA1  LINUX: ${SHA1_LINUX}"

cat > gotty.rb <<EOF
require "formula"

class Gotty < Formula
  homepage "https://github.com/yudai/gotty"
  version '$VERSION'

  url "https://github.com/yudai/gotty/releases/download/$VERSION/${DARWIN_ASSET_NAME}"
  sha1 "$SHA1_DARWIN"

  if OS.linux? && Hardware.is_64_bit?
      url "https://github.com/yudai/gotty/releases/download/$VERSION/${LINUX_ASSET_NAME}"
      sha1 "$SHA1_LINUX"
  end

  depends_on :arch => :intel

  def install
    bin.install 'gotty'
  end

  def caveats
    "GoTTY!"
  end
end
EOF
