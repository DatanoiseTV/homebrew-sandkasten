# Homebrew formula for sandkasten.
#
#   brew tap DatanoiseTV/sandkasten
#   brew install sandkasten
#
# See https://github.com/DatanoiseTV/sandkasten for the source.

class Sandkasten < Formula
  desc     "Fast, kernel-enforced application sandbox for macOS and Linux"
  homepage "https://github.com/DatanoiseTV/sandkasten"
  license  any_of: ["MIT", "Apache-2.0"]
  head     "https://github.com/DatanoiseTV/sandkasten.git", branch: "main"

  url    "https://github.com/DatanoiseTV/sandkasten/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "87553d582448f408a64c8ef76d061bae23ea86a4caa188a93aa5b85ab2269ead"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    # Shell completions shipped alongside the binary.
    generate_completions_from_executable(bin/"sandkasten", "completions")
  end

  test do
    assert_match "self", shell_output("#{bin}/sandkasten templates")
    system "#{bin}/sandkasten", "doctor"
  end
end
