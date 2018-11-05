<#import "root://activities/common/kotlin_macros.ftl" as kt>
<#import "root://gradle-projects/common/proguard_macros.ftl" as proguard>
if (isSingleBuildModule.toBoolean()) {
    apply plugin: 'com.android.application'
} else {
    apply plugin: 'com.android.library'
}
<@kt.addKotlinPlugins />

android {
    compileSdkVersion compile_sdk_version
    
    compileOptions {
        sourceCompatibility 1.8
        targetCompatibility 1.8
    }

    sourceSets {
        main {
            jniLibs.srcDirs = ['libs']
            if (isSingleBuildModule.toBoolean()) {
                manifest.srcFile 'src/main/manifest/debug/AndroidManifest.xml'
            } else {
                manifest.srcFile 'src/main/manifest/release/AndroidManifest.xml'
            }
        }
        
        resourcePrefix "${escapeXmlString(appTitle)}_"
    }
    
    defaultConfig {
        minSdkVersion  min_sdk_version
        targetSdkVersion target_sdk_version
        versionCode version_code
        versionName version_name

        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"

    <#if (includeCppSupport!false) && cppFlags != "">
        externalNativeBuild {
            cmake {
                cppFlags "${cppFlags}"
            }
        }
    </#if>
            javaCompileOptions {
            annotationProcessorOptions {
                arguments = [ moduleName : project.getName() ]
            }
        }
    }

<@proguard.proguardConfig />

<#if includeCppSupport!false>
    externalNativeBuild {
        cmake {
            path "CMakeLists.txt"
        }
    }
</#if>
}

dependencies {
    ${getConfigurationName("compile")} fileTree(dir: 'libs', include: ['*.jar'])
    ${getConfigurationName("compile")}  project(":res")
    ${getConfigurationName("compile")}  project(":common")
    annotationProcessor "com.alibaba:arouter-compiler:${r'${arouter_compiler_version}'}"
    <@kt.addKotlinDependencies />
}
