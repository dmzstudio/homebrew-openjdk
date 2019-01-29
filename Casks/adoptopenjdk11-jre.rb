cask 'adoptopenjdk11-jre' do
  version '11.0.2,7'
  sha256 '53febef8465b4e901309e5b91172a3f91ea3052ba20822abccd1ccb8c37e83a2'

  # github.com/AdoptOpenJDK was verified as official when first introduced to the cask
  url "https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-#{version.before_comma}%2B#{version.after_comma}/OpenJDK11U-jre_x64_mac_hotspot_#{version.before_comma}_#{version.after_comma}.tar.gz"
  appcast 'https://github.com/adoptopenjdk/openjdk11-binaries/releases.atom'
  name 'AdoptOpenJDK'
  homepage 'https://adoptopenjdk.net/'

  postflight do
    system_command '/bin/mv',
                   args: [
                           '-f', '--', "#{staged_path}/jdk-#{version.before_comma}+#{version.after_comma}-jre",
                           "/Library/Java/JavaVirtualMachines/adoptopenjdk-#{version.before_comma}.jre"
                         ],
                   sudo: true

    system_command '/bin/mkdir',
                   args: ['-p', '--', "/Library/Java/JavaVirtualMachines/adoptopenjdk-#{version.before_comma}.jre/Contents/Home/bundle/Libraries"],
                   sudo: true

    system_command '/bin/ln',
                   args: [
                           '-nsf', '--',
                           "/Library/Java/JavaVirtualMachines/adoptopenjdk-#{version.before_comma}.jre/Contents/Home/lib/server/libjvm.dylib",
                           "/Library/Java/JavaVirtualMachines/adoptopenjdk-#{version.before_comma}.jre/Contents/Home/bundle/Libraries/libserver.dylib"
                         ],
                   sudo: true

    system_command '/usr/libexec/PlistBuddy',
                   args: [
                           '-c', "Set :CFBundleGetInfoString AdoptOpenJDK (JRE) #{version.before_comma}+#{version.after_comma}",
                           "/Library/Java/JavaVirtualMachines/adoptopenjdk-#{version.before_comma}.jre/Contents/Info.plist"
                         ],
                   sudo: true

    system_command '/usr/libexec/PlistBuddy',
                   args: [
                           '-c', "Set :CFBundleIdentifier net.adoptopenjdk.#{version.before_comma}.jre",
                           "/Library/Java/JavaVirtualMachines/adoptopenjdk-#{version.before_comma}.jre/Contents/Info.plist"
                         ],
                   sudo: true

    system_command '/usr/libexec/PlistBuddy',
                   args: [
                           '-c', "Set :CFBundleName AdoptOpenJDK (JRE) #{version.before_comma}",
                           "/Library/Java/JavaVirtualMachines/adoptopenjdk-#{version.before_comma}.jre/Contents/Info.plist"
                         ],
                   sudo: true

    system_command '/usr/libexec/PlistBuddy',
                   args: [
                           '-c', "Set :JavaVM:JVMPlatformVersion #{version.before_comma}.#{version.after_comma}",
                           "/Library/Java/JavaVirtualMachines/adoptopenjdk-#{version.before_comma}.jre/Contents/Info.plist"
                         ],
                   sudo: true

    system_command '/usr/libexec/PlistBuddy',
                   args: [
                           '-c', 'Set :JavaVM:JVMVendor AdoptOpenJDK',
                           "/Library/Java/JavaVirtualMachines/adoptopenjdk-#{version.before_comma}.jre/Contents/Info.plist"
                         ],
                   sudo: true

    system_command '/usr/libexec/PlistBuddy',
                   args: [
                           '-c', 'Add :JavaVM:JVMCapabilities array',
                           "/Library/Java/JavaVirtualMachines/adoptopenjdk-#{version.before_comma}.jre/Contents/Info.plist"
                         ],
                   sudo: true

    system_command '/usr/libexec/PlistBuddy',
                   args: [
                           '-c', 'Add :JavaVM:JVMCapabilities:0 string CommandLine',
                           "/Library/Java/JavaVirtualMachines/adoptopenjdk-#{version.before_comma}.jre/Contents/Info.plist"
                         ],
                   sudo: true
  end

  uninstall delete: "/Library/Java/JavaVirtualMachines/adoptopenjdk-#{version.before_comma}.jre"
end
