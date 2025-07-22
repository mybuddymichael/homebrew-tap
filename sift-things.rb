# typed: false
# frozen_string_literal: true

class SiftThings < Formula
  desc "A task prioritization tool"
  homepage "https://github.com/mybuddymichael/sift"
  url "https://github.com/mybuddymichael/sift/archive/v0.0.1-test.tar.gz"
  version "v0.0.1-test"
  license "MIT"
  depends_on "go" => :build
  depends_on :macos

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  test do
    system "#{bin}/sift", "--version"
  end
end
