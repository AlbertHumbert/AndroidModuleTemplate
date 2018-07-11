# How To Use

* copy all the files to adroid/lib/templates/gradle-projects in Android Studio path
* create a new feature/res/base module like normal module supported by Android Studio
* create version.gradle in root project to provide gradle version


      ext {

        compile_sdk_version = 27
        min_sdk_version = 16
        target_sdk_version = 26

        version_code = 1
        version_name = "1.0"


        arouter_version = "1.2.4"
        arouter_compiler_version = "1.1.4"

      }

* add isSingleBuildModule in gradle.properties

      isSingleBuildModule = false //release
      //isSingleBuildModule = true //debug

* if any error occurs during the build proccess, check the gradle files and remove unsupported compile/implementation declarations
