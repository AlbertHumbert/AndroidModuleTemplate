<#import "root://activities/common/kotlin_macros.ftl" as kt>
<#import "root://gradle-projects/common/proguard_macros.ftl" as proguard>
    apply plugin: 'com.android.library'
<@kt.addKotlinPlugins />

android {
    compileSdkVersion <#if buildApiString?matches("^\\d+$")>${buildApiString}<#else>'${buildApiString}'</#if>
    <#if compareVersionsIgnoringQualifiers(gradlePluginVersion, '3.0.0') lt 0>buildToolsVersion "${buildToolsVersion}"</#if>

    sourceSets {
        main {
            jniLibs.srcDirs = ['libs']
                manifest.srcFile 'src/main/manifest/release/AndroidManifest.xml'
        }
        
        resourcePrefix "${escapeXmlString(appTitle)}_"
    }
    
    defaultConfig {
        minSdkVersion <#if minApi?matches("^\\d+$")>${minApi}<#else>'${minApi}'</#if>
        targetSdkVersion <#if targetApiString?matches("^\\d+$")>${targetApiString}<#else>'${targetApiString}'</#if>
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
	api('com.alibaba:arouter-api:1.2.4') {
        exclude module: 'support-v4'
    }
    annotationProcessor 'com.alibaba:arouter-compiler:1.1.4'
    ${getConfigurationName("compile")}  project(":commonres")
    <@kt.addKotlinDependencies />
}
