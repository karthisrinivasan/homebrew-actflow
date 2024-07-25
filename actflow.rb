# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Actflow < Formula
  desc "Top-level repository for the ACT EDA flow"
  homepage "https://avlsi.csl.yale.edu/act/"
  url "https://github.com/karthisrinivasan/actflow/archive/refs/tags/test2.tar.gz"
  version "test"
  sha256 "3c9dacf73b3acf7c8b099c3126c19ee84a6787b1ae224740d76e67454b03c754"
  license "GPL-2.0"

  # depends_on "cmake" => :build

  def install
    # Remove unrecognized options if they cause configure to fail
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    # system "./configure", "--disable-silent-rules", *std_configure_args
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
	system "mv git .git"
	system "mv gitignore .gitignore"
	system "mv gitmodules .gitmodules"
	system "git submodule update --init --recursive"
  ENV["ACT_HOME"] = prefix.getwd
	system "./build"
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
