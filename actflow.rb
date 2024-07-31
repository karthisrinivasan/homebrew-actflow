# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Actflow < Formula
  desc "Top-level repository for the ACT EDA flow"
  homepage "https://avlsi.csl.yale.edu/act/"
  url "https://github.com/asyncvlsi/actflow.git", branch: "main"
  version "main"
  license "GPL-2.0"

  depends_on "llvm"
  depends_on "cmake"
  depends_on "boost"
  depends_on "libomp"

  def install
    ENV.deparallelize
    ENV["CXX"] = "#{HOMEBREW_PREFIX}/opt/llvm/bin/clang++"
    ENV["HOMEBREW_LIBOMP_PREFIX"] = "#{HOMEBREW_PREFIX}/opt/libomp"
    system "mkdir act_tools"
    prefix.install Dir["act_tools"]
    ENV["ACT_HOME"] = "#{prefix}/act_tools"
    system "./build"
    prefix.install Dir["act_tools"]
  end
  
  def caveats
    <<~EOS

      Actflow successfully installed.
      Install location: #{prefix}/act_tools/
      Add the following to your .rc file:
      
      export ACT_HOME=#{prefix}/act_tools
      export PATH=#{prefix}/act_tools/bin:$PATH
    
    EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test actflow`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    # system "false"
  end
end
