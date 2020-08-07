<?xml version="1.0"?>
<recipe>
     
    <dependency mavenUrl="com.squareup.retrofit2:adapter-rxjava2:2.8.1"/>
    <dependency mavenUrl="com.squareup.retrofit2:retrofit:2.8.1"/>
    <dependency mavenUrl="com.squareup.retrofit2:converter-gson:2.8.1"/>
    <dependency mavenUrl="com.squareup.okhttp3:logging-interceptor:4.4.1"/>
    <dependency mavenUrl="com.squareup.okhttp3:okhttp:4.4.1"/>
    <dependency mavenUrl="org.jetbrains.kotlinx:kotlinx-coroutines-android:1.3.5"/>

    <instantiate from="src/app_package/data/BaseRemoteRepository.kt.ftl"
                 to="${escapeXmlAttribute(srcOut)}/data/BaseRemoteRepository.kt" />

    <instantiate from="src/app_package/exceptions/NetworkException.kt.ftl"
                 to="${escapeXmlAttribute(srcOut)}/exceptions/NetworkException.kt" />
   
    <instantiate from="src/app_package/extensions/ResultExt.kt.ftl"
                 to="${escapeXmlAttribute(srcOut)}/extensions/ResultExt.kt" />

    <instantiate from="src/app_package/Result.kt.ftl"
                 to="${escapeXmlAttribute(srcOut)}/Result.kt" />

    <instantiate from="src/app_package/ServiceFactory.kt.ftl"
                 to="${escapeXmlAttribute(srcOut)}/ServiceFactory.kt" />

    <instantiate from="src/app_package/ServiceFactoryParameters.kt.ftl"
                 to="${escapeXmlAttribute(srcOut)}/ServiceFactoryParameters.kt" />


</recipe>