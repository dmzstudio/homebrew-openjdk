# PLEASE DO NOT EDIT THIS FILE. EDIT Templates/adoptopenjdk.rb.tmpl
cask "adoptopenjdk15-jre" do
  version "15.0.1,9.1"
  sha256 "325ed874e67a5ca8cd56256d033f03740265694f1986b7c25424b86e10ecce2f"

  # github.com/AdoptOpenJDK was verified as official when first introduced to the cask
  url "https://github.com/AdoptOpenJDK/openjdk15-binaries/releases/download/jdk-15.0.1%2B9.1/OpenJDK15U-jre_x64_mac_hotspot_15.0.1_9.pkg"
  appcast "https://github.com/AdoptOpenJDK/openjdk#{version.major}-binaries/releases/latest"
  name "AdoptOpenJDK 15 (JRE)"
  desc "AdoptOpenJDK OpenJDK (Java) Development Kit"
  homepage "https://adoptopenjdk.net/"

  pkg "OpenJDK15U-jre_x64_mac_hotspot_15.0.1_9.pkg"

  postflight do
    system_command "/usr/sbin/pkgutil", args: ["--pkg-info", "net.adoptopenjdk.15.jre"], print_stdout: true
  end

  uninstall pkgutil: "net.adoptopenjdk.15.jre"
end
