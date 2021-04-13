class Moreutils < Formula
  desc "Collection of tools that nobody wrote when UNIX was young"
  homepage "https://joeyh.name/code/moreutils/"
  url "https://git.joeyh.name/git/moreutils.git",
      tag:      "0.65",
      revision: "c3261f4190c3803177b6c50ec43fd302171dd48e"
  license all_of: [
    "GPL-2.0-or-later",
    { any_of: ["GPL-2.0-only", "Artistic-2.0"] },
  ]
  head "https://git.joeyh.name/git/moreutils.git"

  option "without-parallel", "Build without the 'parallel' tool."
  option "without-errno", "Build without the 'errno' tool, for compatibility with 'pwntools'."
  option "without-sponge", "Build without the 'sponge' tool, for compatibility with 'sponge'."
  option "without-ts", "Build without the 'ts' tool, for compatibility with 'task-spooler'."

  depends_on "docbook-xsl" => :build

  uses_from_macos "libxml2" => :build
  uses_from_macos "libxslt" => :build

  uses_from_macos "perl"

  conflicts_with "parallel", because: "Both install a `parallel` executable." if build.with? "parallel"
  conflicts_with "pwntools", because: "Both install an `errno` executable." if build.with? "errno"
  conflicts_with "sponge", because: "both install a `sponge` executable" if build.with? "sponge"
  conflicts_with "task-spooler", because: "Both install a `ts` executable." if build.with? "ts"

  resource "Time::Duration" do
    url "https://cpan.metacpan.org/authors/id/N/NE/NEILB/Time-Duration-1.20.tar.gz"
    sha256 "458205b528818e741757b2854afac5f9af257f983000aae0c0b1d04b5a9cbbb8"
  end

  resource "IPC::Run" do
    url "https://cpan.metacpan.org/authors/id/T/TO/TODDR/IPC-Run-0.94.tar.gz"
    sha256 "2eb336c91a2b7ea61f98e5b2282d91020d39a484f16041e2365ffd30f8a5605b"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    resource("Time::Duration").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}", "--skipdeps"
      system "make", "install"
    end

    resource("IPC::Run").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make", "install"
    end

    inreplace "Makefile" do |s|
      s.gsub! "/usr/share/xml/docbook/stylesheet/docbook-xsl",
              "#{Formula["docbook-xsl"].opt_prefix}/docbook-xsl"
      %w[parallel errno sponge ts].each do |util|
        next if build.with? util

        s.gsub!(/^BINS=.*\K#{util}/, "", false)
        s.gsub!(/^MANS=.*\K#{util}\.1/, "")
        s.gsub!(/^PERLSCRIPTS=.*\K#{util}/, "", false)
      end
    end
    system "make", "all"
    system "make", "install", "PREFIX=#{prefix}"
    bin.env_script_all_files(libexec/"bin", PERL5LIB: ENV["PERL5LIB"])
  end

  test do
    pipe_output("#{bin}/isutf8", "hello", 0)
    pipe_output("#{bin}/isutf8", "\xca\xc0\xbd\xe7", 1)
  end
end
