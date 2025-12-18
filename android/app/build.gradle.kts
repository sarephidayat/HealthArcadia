plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.healtharcadia"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // ENABLE DESUGARING
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.healtharcadia"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // REQUIRED FOR flutter_local_notifications
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.3")
    // FIREBASE BOM
    implementation(platform("com.google.firebase:firebase-bom:34.6.0"))

    // FIREBASE SERVICES — Tambahkan sesuai kebutuhan
    implementation("com.google.firebase:firebase-analytics")
}

apply(plugin = "com.google.gms.google-services")
