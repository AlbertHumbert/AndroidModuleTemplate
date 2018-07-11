<?xml version="1.0"?>
<!-- TODO: check include Cpp support; add driver module template -->
<recipe>
    <mkdir at="${escapeXmlAttribute(projectOut)}/libs" />
    <mkdir at="${escapeXmlAttribute(resOut)}/drawable" />
    <mkdir at="${escapeXmlAttribute(resOut)}/mipmap-anydpi-v26" />
    <mkdir at="${escapeXmlAttribute(resOut)}/drawable-v24" />
    <mkdir at="${escapeXmlAttribute(resOut)}/mipmap-anydpi-v26" />
   <mkdir at="${escapeXmlAttribute(resOut)}/mipmap-hdpi" />
   <mkdir at="${escapeXmlAttribute(resOut)}/mipmap-mdpi" />
   <mkdir at="${escapeXmlAttribute(resOut)}/mipmap-xhdpi" />
   <mkdir at="${escapeXmlAttribute(resOut)}/mipmap-xxhdpi" />
   <mkdir at="${escapeXmlAttribute(resOut)}/mipmap-xxxhdpi" />

    <mkdir at="${escapeXmlAttribute(projectOut)}/src/main/manifest" />
    <mkdir at="${escapeXmlAttribute(manifestOut)}/manifest/debug" />
    <mkdir at="${escapeXmlAttribute(manifestOut)}/manifest/release" />
    <merge from="root/settings.gradle.ftl"
             to="${escapeXmlAttribute(topOut)}/settings.gradle" />

    <instantiate from="root/build.gradle.ftl"
                   to="${escapeXmlAttribute(projectOut)}/build.gradle" />
    <instantiate from="root/DebugAndroidManifest.xml.ftl"
                   to="${escapeXmlAttribute(manifestOut)}/manifest/debug/AndroidManifest.xml" />
    <instantiate from="root/ReleaseAndroidManifest.xml.ftl"
                   to="${escapeXmlAttribute(manifestOut)}/manifest/release/AndroidManifest.xml" />
    <instantiate from="root/res/values/strings.xml.ftl"
                   to="${escapeXmlAttribute(resOut)}/values/strings.xml" />
    <instantiate from="root/res/values/attrs.xml.ftl"
                   to="${escapeXmlAttribute(resOut)}/values/attrs.xml" />
    <instantiate from="root/res/values/dimens.xml.ftl"
                   to="${escapeXmlAttribute(resOut)}/values/dimens.xml" />  
    <instantiate from="root/res/values/colors.xml.ftl"
                   to="${escapeXmlAttribute(resOut)}/values/colors.xml" />
    <instantiate from="root/res/values/styles.xml.ftl"
                   to="${escapeXmlAttribute(resOut)}/values/styles.xml" />
    <instantiate from="root/test/app_package/ExampleInstrumentedTest.${ktOrJavaExt}.ftl"
                   to="${escapeXmlAttribute(testOut)}/ExampleInstrumentedTest.${ktOrJavaExt}" />


        <copy from="root/res/mipmap-anydpi-v26/ic_launcher.xml"
                to="${escapeXmlAttribute(resOut)}/mipmap-anydpi-v26/ic_launcher.xml" />
        <copy from="root/res/drawable/ic_launcher_background.xml"
                to="${escapeXmlAttribute(resOut)}/drawable/ic_launcher_background.xml" />
        <copy from="root/res/drawable-v24/ic_launcher_foreground.xml"
                to="${escapeXmlAttribute(resOut)}/drawable-v24/ic_launcher_foreground.xml" />
        <copy from="root/res/mipmap-anydpi-v26/ic_launcher_round.xml"
                to="${escapeXmlAttribute(resOut)}/mipmap-anydpi-v26/ic_launcher_round.xml" />
                
    <copy from="root/res/mipmap-hdpi/ic_launcher.png"
            to="${escapeXmlAttribute(resOut)}/mipmap-hdpi/ic_launcher.png" />
    <copy from="root/res/mipmap-mdpi/ic_launcher.png"
            to="${escapeXmlAttribute(resOut)}/mipmap-mdpi/ic_launcher.png" />
    <copy from="root/res/mipmap-xhdpi/ic_launcher.png"
            to="${escapeXmlAttribute(resOut)}/mipmap-xhdpi/ic_launcher.png" />
    <copy from="root/res/mipmap-xxhdpi/ic_launcher.png"
            to="${escapeXmlAttribute(resOut)}/mipmap-xxhdpi/ic_launcher.png" />
    <copy from="root/res/mipmap-xxxhdpi/ic_launcher.png"
            to="${escapeXmlAttribute(resOut)}/mipmap-xxxhdpi/ic_launcher.png" />
            
   <copy from="root/res/mipmap-hdpi/ic_launcher_round.png"
            to="${escapeXmlAttribute(resOut)}/mipmap-hdpi/ic_launcher_round.png" />
    <copy from="root/res/mipmap-mdpi/ic_launcher_round.png"
            to="${escapeXmlAttribute(resOut)}/mipmap-mdpi/ic_launcher_round.png" />
    <copy from="root/res/mipmap-xhdpi/ic_launcher_round.png"
            to="${escapeXmlAttribute(resOut)}/mipmap-xhdpi/ic_launcher_round.png" />
    <copy from="root/res/mipmap-xxhdpi/ic_launcher_round.png"
            to="${escapeXmlAttribute(resOut)}/mipmap-xxhdpi/ic_launcher_round.png" />
    <copy from="root/res/mipmap-xxxhdpi/ic_launcher_round.png"
            to="${escapeXmlAttribute(resOut)}/mipmap-xxxhdpi/ic_launcher_round.png" />


<#if unitTestsSupported>
    <instantiate from="root/test/app_package/ExampleUnitTest.${ktOrJavaExt}.ftl"
                   to="${escapeXmlAttribute(unitTestOut)}/ExampleUnitTest.${ktOrJavaExt}" />
    <dependency mavenUrl="junit:junit:4.12" gradleConfiguration="testCompile" />
</#if>

<dependency mavenUrl="com.android.support.test:runner:+" gradleConfiguration="androidTestCompile" />
<dependency mavenUrl="com.android.support.test.espresso:espresso-core:+" gradleConfiguration="androidTestCompile" />

<#if !createActivity>
    <mkdir at="${escapeXmlAttribute(srcOut)}" />
</#if>

<#if makeIgnore>
    <copy from="root://gradle-projects/common/gitignore"
            to="${escapeXmlAttribute(projectOut)}/.gitignore" />
</#if>

    <#include "root://gradle-projects/common/proguard_recipe.xml.ftl"/>

<#if includeCppSupport>
    <mkdir at="${escapeXmlAttribute(nativeSrcOut)}" />

    <instantiate from="root/CMakeLists.txt.ftl"
                   to="${escapeXmlAttribute(projectOut)}/CMakeLists.txt" />
    <instantiate from="root/native-lib.cpp.ftl"
                   to="${escapeXmlAttribute(nativeSrcOut)}/native-lib.cpp" />
</#if>

</recipe>
