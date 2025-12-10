# typed: false
# frozen_string_literal: true

class Mint < Formula
  desc "A (very) simple command line tool to track work on a software project."
  homepage "https://github.com/mybuddymichael/mint"
  url "https://github.com/mybuddymichael/mint/archive/v0.9.0.tar.gz"
  sha256 "34124a48e573c677b4d0059f6ca42c0b7fee70635d82faefbbbdad4121cbc9b3"
  version "v0.9.0".delete_prefix("v")
  license "MIT"

  head do
    url "https://github.com/mybuddymichael/mint.git", branch: "main"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", *std_go_args(output: bin/"mint", ldflags: "-s -w -X main.version=v0.9.0"), "."
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
