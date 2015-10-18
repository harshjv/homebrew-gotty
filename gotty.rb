require "formula"

class Gotty < Formula
  homepage "https://github.com/yudai/gotty"
  version 'v0.0.12'

  url "https://github.com/yudai/gotty/releases/download/v0.0.12/gotty_darwin_amd64.tar.gz"
  sha1 "60d6200e6c750481ebdc963de58987e6c4921ad5"

  if OS.linux? && Hardware.is_64_bit?
      url "https://github.com/yudai/gotty/releases/download/v0.0.12/gotty_linux_amd64.tar.gz"
      sha1 "9d4330b62b220b606b739524c2b880916771bd2e"
  end

  depends_on :arch => :intel

  def install
    bin.install 'gotty'
  end

  def caveats
    "GoTTY!"
  end
end
