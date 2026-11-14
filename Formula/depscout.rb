class Depscout < Formula
  desc "Understand every dependency in your Rust project: advisories, unused dependencies, licenses, versions and why each one is there"
  homepage "https://github.com/HarpeLm/DepScout#readme"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HarpeLm/DepScout/releases/download/v0.2.0/depscout-aarch64-apple-darwin.tar.xz"
      sha256 "3041f5747a66a00efa179aa7fc0feb879109e150eee2ec629b56a38a39613c18"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HarpeLm/DepScout/releases/download/v0.2.0/depscout-x86_64-apple-darwin.tar.xz"
      sha256 "721bddc4825d175ef3be96e35ed3fceb19341b2d3350fd0b84d84221ce283a8c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HarpeLm/DepScout/releases/download/v0.2.0/depscout-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a9bd60fa7f1c99a54fb1c64346da585570ca1af9d17dfeb477ff8cab3d90c2bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HarpeLm/DepScout/releases/download/v0.2.0/depscout-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "64ae163125bcebb864f98f3d0bef5429a154dd23d134563289a3c9582af39d39"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "depscout"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "depscout"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "depscout"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "depscout"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
