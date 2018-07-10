<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="${packageName}">
    
     <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.INTERNET" />

    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
   
     <application android:allowBackup="true"
     	  android:icon="@mipmap/ic_launcher"
     	  android:roundIcon="@mipmap/ic_launcher_round"
        android:label="@string/${escapeXmlString(appTitle)}_app_name"
        android:supportsRtl="true"
        android:theme="@style/AppTheme">
       </application>
</manifest>
