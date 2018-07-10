<#import "root://activities/common/kotlin_macros.ftl" as kt>
<#import "root://gradle-projects/common/proguard_macros.ftl" as proguard>
if (isSingleBuildModule.toBoolean()) {
    apply plugin: 'com.android.application'
} else {
    apply plugin: 'com.android.library'
}
<@kt.addKotlinPlugins />

android {
    compileSdkVersion <#if buildApiString?matches("^\\d+$")>${buildApiString}<#else>'${buildApiString}'</#if>
    <#if compareVersionsIgnoringQualifiers(gradlePluginVersion, '3.0.0') lt 0>buildToolsVersion "${buildToolsVersion}"</#if>

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
        minSdkVersion 19
        targetSdkVersion 27
        versionCode 1
        versionName "1.0"

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
<#if javaVersion?? && (javaVersion != "1.6" && buildApi lt 21 || javaVersion != "1.7")>

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_${javaVersion?replace('.','_','i')}
        targetCompatibility JavaVersion.VERSION_${javaVersion?replace('.','_','i')}
    }
</#if>

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
    <@kt.addKotlinDependencies />
}
