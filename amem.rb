# typed: false
# frozen_string_literal: true

class Amem < Formula
  desc "Command-line tool that gives an LLM agent memory"
  homepage "https://github.com/mybuddymichael/amem"
  url "https://github.com/mybuddymichael/amem/archive/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  version "v0.1.0".delete_prefix("v")
  license "MIT"

  head do
    url "https://github.com/mybuddymichael/amem.git", branch: "main"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", *std_go_args(output: bin/"amem", ldflags: "-s -w"), "."
  end

  test do
    # Test that binary exists and is executable
    assert_predicate bin/"amem", :exist?
    assert_predicate bin/"amem", :executable?

    # Test help command
    assert_match "agent memory", shell_output("#{bin}/amem help")
  end
end
