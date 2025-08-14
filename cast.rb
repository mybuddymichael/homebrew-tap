# typed: false
# frozen_string_literal: true

class Cast < Formula
  desc "A tiny command line utility that converts colors from one format to another"
  homepage "https://github.com/mybuddymichael/cast"
  url "https://github.com/mybuddymichael/cast/archive/v0.3.0.tar.gz"
  sha256 "64ef4daed22919076e962c7b845bf79ee1a2963e4c2a0eb85c2c8236a2a93c4e"
  version "v0.3.0".delete_prefix("v")
  license "MIT"
  
  head do
    url "https://github.com/mybuddymichael/cast.git", branch: "main"
  end
  
  depends_on "bun" => :build

  def install
    system "bun", "install"
    system "bun", "build", "index.ts", "--compile", "--minify", "--bytecode", "--outfile=bin/cast"
    bin.install "bin/cast"
  end          

  test do
    # Test that binary exists and is executable
    assert_predicate bin/"cast", :exist?
    assert_predicate bin/"cast", :executable?
    
    # Test basic color conversion functionality
    output = shell_output("#{bin}/cast '#ff0000' --to-rgb")
    assert_match(/rgb\(100% 0% 0%\)/, output)
    
    # Verify it's a valid binary
    if OS.mac?
      assert_match "Mach-O", shell_output("file #{bin}/cast")
    end
  end
end
