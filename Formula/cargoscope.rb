class Cargoscope < Formula
  desc "Understand every dependency in your Rust project: advisories, unused dependencies, licenses, versions and why each one is there"
  homepage "https://github.com/HarpeLm/CargoScope#readme"
  version "0.7.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.7.5/cargoscope-aarch64-apple-darwin.tar.xz"
      sha256 "cd82211bb2fa146c2b6f26ab5810ba0ae952f03cc104ac990668c32bc03ce18f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.7.5/cargoscope-x86_64-apple-darwin.tar.xz"
      sha256 "3ad4b743fab37cca6bdd29f1dbfe44e4c46cce4a217290e40cb1d6650e827f96"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.7.5/cargoscope-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b4310478c59888d640c8680c902cce9990e318b73a8f319076bec427a86a2dfb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.7.5/cargoscope-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a0729609e7f419235f20439d4e966fbe713a7ecc76f7755acd42372c0d6f958e"
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
