# source ~/.custom_bash_commands.sh
# greet the user
    export LANG=en_US.UTF-8

function greet() {
      echo ‘Hello’ $1‘!’
}

# Flutter variable set
function setBashVariable() {
    export PATH="$PATH:/Users/krishnakant.chouhan/Documents/flutter/bin"
    echo ‘Variable Set’   
}

# Flutter clean & build
function dashBuild() {
    setBashVariable
    flutter clean
    flutter pub get
    flutter run
    echo ‘Run the app’
}

# Flutter clean run
function dashRun() {
    setBashVariable
    flutter doctor
    flutter clean
    flutter pub get
    cd ios
    pod install --repo-update
    cd ..
    flutter run
    echo ‘App is running’
}
# Flutter clean run
function dashRunUat() {
    setBashVariable
    flutter clean
    flutter pub get
    flutter run -t lib/main_uat.dart --flavor uat
    # shellcheck disable=SC1110
    echo ‘App is running’
}

# Flutter clean run
function dashRunUatSbi() {
    setBashVariable
    flutter clean
    flutter pub get
    flutter run -t lib/main_uat_sbic.dart --flavor uat
    echo ‘App is running’
}

# Flutter ios run
function dashRunIosBuild() {
    setBashVariable
    flutter clean
    flutter pub get
    pod install --repo-update
    echo ‘App is built for iOS’
}

# Flutter clean run
function dashRunAndroidDedug() {
    setBashVariable
    flutter clean
    flutter pub get
    flutter run -t lib/main.dart
    echo ‘App is running’
}

# Flutter clean run
function dashApk() {
    setBashVariable
    flutter clean
    flutter pub get
    flutter build apk --release
    echo ‘App is running’
}

function mobsf(){
    brew install pyenv
    brew cleanup pyenv
    pyenv install 3.9
    pyenv global 3.9

    git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git
    cd Mobile-Security-Framework-MobSF
    ./setup.sh
    ./run.sh 127.0.0.1:8000
}

function createApp(){
    flutter config
    flutter doctor
    flutter config --android-studio-dir: /Users/krishnakant.chouhan/Documents/Android Studio.app/Contents
    flutter create app --project-name dashapp --org DashApp 
    cd app
    flutter run
    flutter analyze
    flutter clean
    flutter pub get
    flutter pub upgrade 
    flutter pub outdated 
    flutter run 
    #choose device   
}
 
#  Create a new Flutter project.

# If run on a project that already exists, this will repair the project, recreating any files that are missing.

# Global options:
# -h, --help                  Print this usage information.
# -v, --verbose               Noisy logging, including all shell commands executed.
#                             If used with "--help", shows hidden options. If used with "flutter doctor", shows additional diagnostic information. (Use "-vv" to force
#                             verbose logging in those cases.)
# -d, --device-id             Target device id or name (prefixes allowed).
#     --version               Reports the version of this tool.
#     --suppress-analytics    Suppress analytics reporting when this command runs.

# Usage: flutter create <output directory>
# -h, --help                   Print this usage information.
#     --[no-]pub               Whether to run "flutter pub get" after the project has been created.
#                              (defaults to on)
#     --[no-]offline           When "flutter pub get" is run by the create command, this indicates whether to run it in offline mode or not. In offline mode, it will need
#                              to have all dependencies already available in the pub cache to succeed.
#     --[no-]overwrite         When performing operations, overwrite existing files.
#     --description            The description to use for your new Flutter project. This string ends up in the pubspec.yaml file.
#                              (defaults to "A new Flutter project.")
#     --org                    The organization responsible for your new Flutter project, in reverse domain name notation. This string is used in Java package names and
#                              as prefix in the iOS bundle identifier.
#                              (defaults to "com.example")
#     --project-name           The project name for this new Flutter project. This must be a valid dart package name.
# -i, --ios-language           The language to use for iOS-specific code, either Objective-C (legacy) or Swift (recommended).
#                              [objc, swift (default)]
# -a, --android-language       The language to use for Android-specific code, either Java (legacy) or Kotlin (recommended).
#                              [java, kotlin (default)]
#     --platforms              The platforms supported by this project. Platform folders (e.g. android/) will be generated in the target project. This argument only works
#                              when "--template" is set to app or plugin. When adding platforms to a plugin project, the pubspec.yaml will be updated with the requested
#                              platform. Adding desktop platforms requires the corresponding desktop config setting to be enabled.
#                              [ios (default), android (default), windows (default), linux (default), macos (default), web (default)]
# -t, --template=<type>        Specify the type of project to create.

#           [app]              (default) Generate a Flutter application.
#           [module]           Generate a project to add a Flutter module to an existing Android or iOS application.
#           [package]          Generate a shareable Flutter project containing modular Dart code.
#           [plugin]           Generate a shareable Flutter project containing an API in Dart code with a platform-specific implementation through method channels for
#                              Android, iOS, Linux, macOS, Windows, web, or any combination of these.
#           [plugin_ffi]       Generate a shareable Flutter project containing an API in Dart code with a platform-specific implementation through dart:ffi for Android,
#                              iOS, Linux, macOS, Windows, or any combination of these.
#           [skeleton]         Generate a List View / Detail View Flutter application that follows community best practices.

# -s, --sample=<id>            Specifies the Flutter code sample to use as the "main.dart" for an application. Implies "--template=app". The value should be the sample ID
#                              of the desired sample from the API documentation website (http://docs.flutter.dev/). An example can be found at:
#                              https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html
# -e, --[no-]empty             Specifies creating using an application template with a main.dart that is minimal, including no comments, as a starting point for a new
#                              application. Implies "--template=app".
#     --list-samples=<path>    Specifies a JSON output file for a listing of Flutter code samples that can be created with "--sample".

# Run "flutter help" to see global options.
