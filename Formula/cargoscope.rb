class Cargoscope < Formula
  desc "Understand every dependency in your Rust project: advisories, unused dependencies, licenses, versions and why each one is there"
  homepage "https://github.com/HarpeLm/CargoScope#readme"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.5.1/cargoscope-aarch64-apple-darwin.tar.xz"
      sha256 "7a35e846f260c12a1c1d353af11cdc3dec66edf8bbe2237aba57f45f280d4e55"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.5.1/cargoscope-x86_64-apple-darwin.tar.xz"
      sha256 "8f5588a6d0e088ebf55cc5b98a14ba8c309fb8b11d402c066747d8b79bf9a29c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.5.1/cargoscope-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9279a028a09efc267427f52c40809407c5b5897a94cc37364603049463969773"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.5.1/cargoscope-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a80dd966c786f50c44eec7fb0bd39c99a5d1e1607b312f439d134faf2ef5a64c"
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
