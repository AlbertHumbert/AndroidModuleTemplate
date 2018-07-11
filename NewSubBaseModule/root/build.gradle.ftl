<#import "root://activities/common/kotlin_macros.ftl" as kt>
<#import "root://gradle-projects/common/proguard_macros.ftl" as proguard>
    apply plugin: 'com.android.library'
<@kt.addKotlinPlugins />

android {
    compileSdkVersion compile_sdk_version

    sourceSets {
        main {
            jniLibs.srcDirs = ['libs']
                manifest.srcFile 'src/main/manifest/release/AndroidManifest.xml'
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
	api("com.alibaba:arouter-api:${r'${arouter_version}'}") {
        exclude module: 'support-v4'
    }
    
    annotationProcessor "com.alibaba:arouter-compiler:${r'${arouter_compiler_version}'}"
    ${getConfigurationName("compile")}  project(":commonres")
    <@kt.addKotlinDependencies />
}
