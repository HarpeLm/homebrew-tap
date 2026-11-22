class Cargoscope < Formula
  desc "Understand every dependency in your Rust project: advisories, unused dependencies, licenses, versions and why each one is there"
  homepage "https://github.com/HarpeLm/CargoScope#readme"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.11.0/cargoscope-aarch64-apple-darwin.tar.xz"
      sha256 "f9477a0dfcbdb72a52bd7d7c03e75ea4ebe0aeaf62fcd0b45b09c9c789fd45d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.11.0/cargoscope-x86_64-apple-darwin.tar.xz"
      sha256 "f61a10294146fd66657ff5ac32962572851d02ff685b24e12bbd5e96b98368e7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.11.0/cargoscope-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c5d91ca3588091157332c92045940464850da6411d67e5eef8838c923982720a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.11.0/cargoscope-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1084b0726ad6d7c98c5ab4a61dd7a5136b4a391365b1110787587ba41211636a"
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
      bin.install "cargoscope"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cargoscope"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cargoscope"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cargoscope"
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
