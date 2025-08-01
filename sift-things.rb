# typed: false
# frozen_string_literal: true

class SiftThings < Formula
  desc "Terminal-based task prioritization tool for Things.app"
  homepage "https://github.com/mybuddymichael/sift"
  url "https://github.com/mybuddymichael/sift/archive/v0.3.0.tar.gz"
  sha256 "0147c2ab7d79903a43455133fc9e1106345bd395699e7cd076b6dbb95c72ba39"
  version "v0.3.0".delete_prefix("v")
  license "MIT"
  
  head do
    url "https://github.com/mybuddymichael/sift.git", branch: "main"
  end
  
  depends_on "go" => :build
  depends_on :macos

  def install
    system "go", "build", "-trimpath", *std_go_args(output: bin/"sift", ldflags: "-s -w"), "."
  end          

  test do
    # Test that binary exists and is executable
    assert_predicate bin/"sift", :exist?
    assert_predicate bin/"sift", :executable?
    
    # For TUI apps, we can only test basic binary functionality
    # without requiring user interaction or external dependencies
    
    # Test that the binary can be invoked (will exit quickly in test environment)
    # Use timeout to prevent hanging in CI
    system "timeout", "2s", bin/"sift" rescue nil
    
    # Verify it's a valid Mach-O binary on macOS
    if OS.mac?
      assert_match "Mach-O", shell_output("file #{bin}/sift")
    end
  end
end
