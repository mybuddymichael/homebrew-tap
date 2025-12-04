# typed: false
# frozen_string_literal: true

class Mint < Formula
  desc "A (very) simple command line tool to track work on a software project."
  homepage "https://github.com/mybuddymichael/mint"
  url "https://github.com/mybuddymichael/mint/archive/v0.7.0.tar.gz"
  sha256 "3bbe20a497a975b3606663b5214d617086ea4e7bb4edf7d7baa4bd7569dbc88a"
  version "v0.7.0".delete_prefix("v")
  license "MIT"

  head do
    url "https://github.com/mybuddymichael/mint.git", branch: "main"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", *std_go_args(output: bin/"mint", ldflags: "-s -w -X main.version=v0.7.0"), "."
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
