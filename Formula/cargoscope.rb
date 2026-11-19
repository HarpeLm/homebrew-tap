class Cargoscope < Formula
  desc "Understand every dependency in your Rust project: advisories, unused dependencies, licenses, versions and why each one is there"
  homepage "https://github.com/HarpeLm/CargoScope#readme"
  version "0.9.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.9.1/cargoscope-aarch64-apple-darwin.tar.xz"
      sha256 "3209d8a28785eec25b4124dbf024149a04158aecb0add48f135c1559cd394126"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.9.1/cargoscope-x86_64-apple-darwin.tar.xz"
      sha256 "f8815b718c0ec8542dab75b3fae4d1d116e58ac3164c42e8d2e2cc50f8cad921"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.9.1/cargoscope-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1196163434fe402375975086ebe312665077d272961c51fc7e025c53e0106351"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.9.1/cargoscope-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6f3f376471a14422f908316cb8116cc89ef7626f95e745b2c3b7e7f25f5f97fc"
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
