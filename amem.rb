# typed: false
# frozen_string_literal: true

class Amem < Formula
  desc "Command-line tool that gives an LLM agent memory"
  homepage "https://github.com/mybuddymichael/amem"
  url "https://github.com/mybuddymichael/amem/archive/v0.3.0.tar.gz"
  sha256 "ca4ff07ac0a1aa137cb486220dfdd2884f1e948588b8c65ef7eee172b19954d6"
  version "v0.3.0".delete_prefix("v")
  license "MIT"

  head do
    url "https://github.com/mybuddymichael/amem.git", branch: "main"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", *std_go_args(output: bin/"amem", ldflags: "-s -w -X main.version=v0.3.0"), "."
  end

  test do
    # Test that binary exists and is executable
    assert_predicate bin/"amem", :exist?
    assert_predicate bin/"amem", :executable?

    # Test help command
    assert_match "agent memory", shell_output("#{bin}/amem help")
  end
end
