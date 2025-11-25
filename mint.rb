# typed: false
# frozen_string_literal: true

class Mint < Formula
  desc "A (very) simple command line tool to track work on a software project."
  homepage "https://github.com/mybuddymichael/mint"
  url "https://github.com/mybuddymichael/mint/archive/v0.4.0.tar.gz"
  sha256 "0dde59a25988e5024a953b1de6cd57629dc231d4bb1cc5e76cbbb92674b40f57"
  version "v0.4.0".delete_prefix("v")
  license "MIT"

  head do
    url "https://github.com/mybuddymichael/mint.git", branch: "main"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", *std_go_args(output: bin/"mint", ldflags: "-s -w -X main.version=v0.4.0"), "."
    generate_completions_from_executable(bin/"mint", "completion")
  end

  test do
    # Test that binary exists and is executable
    assert_predicate bin/"mint", :exist?
    assert_predicate bin/"mint", :executable?

    # Test help command
    assert_match "agent memory", shell_output("#{bin}/mint help")
  end
end
