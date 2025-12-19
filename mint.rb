# typed: false
# frozen_string_literal: true

class Mint < Formula
  desc "A (very) simple command line tool to track work on a software project."
  homepage "https://github.com/mybuddymichael/mint"
  url "https://github.com/mybuddymichael/mint/archive/v0.9.1.tar.gz"
  sha256 "bf7877e2d876171a42a59f410b1822a1e09c8e091ce9f7b1eb0879ec4e1f12d7"
  version "v0.9.1".delete_prefix("v")
  license "MIT"

  head do
    url "https://github.com/mybuddymichael/mint.git", branch: "main"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", *std_go_args(output: bin/"mint", ldflags: "-s -w -X main.version=v0.9.1"), "."
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
