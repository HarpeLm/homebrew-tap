class Cargoscope < Formula
  desc "Understand every dependency in your Rust project: advisories, unused dependencies, licenses, versions and why each one is there"
  homepage "https://github.com/HarpeLm/CargoScope#readme"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.8.0/cargoscope-aarch64-apple-darwin.tar.xz"
      sha256 "820f9ec42bb1a8889577ca445ff7275d4265572615435a92e4b1a6029c347310"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.8.0/cargoscope-x86_64-apple-darwin.tar.xz"
      sha256 "ddaed198572fc9f6cce24de71f359e7d3d4551e66733e3706dbdfb0ca52add50"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.8.0/cargoscope-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dddd02ca060725eed25ea97be4973aa0b2f29aa5e182e11a6f9327a01ad4fffb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HarpeLm/CargoScope/releases/download/v0.8.0/cargoscope-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "60a8d8665704302aee429d6427dbed9daa72fdcdd7a87d38f6831082311bb502"
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
