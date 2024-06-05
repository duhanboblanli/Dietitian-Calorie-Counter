plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    kotlin("kapt")
    id("com.google.dagger.hilt.android")
    id("com.google.gms.google-services")
    id("androidx.navigation.safeargs.kotlin")
}
android {
    namespace = "com.example.dietitianapp"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.dietitianapp"
        minSdk = 27
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }
    buildFeatures {
        viewBinding = true
        buildConfig = true
    }
    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }
}

dependencies {

    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.appcompat)
    implementation(libs.material)
    implementation(libs.androidx.activity)
    implementation(libs.androidx.constraintlayout)
    //viewbinding
    implementation("com.wada811.viewbindingktx:viewbindingktx:3.1.0")
    //Retrofit
    implementation("com.squareup.retrofit2:retrofit:2.11.0")
    implementation("com.squareup.okhttp3:logging-interceptor:4.12.0")
    //Hilt
    implementation("com.google.dagger:hilt-android:2.48")
    implementation(libs.firebase.firestore.ktx)
    kapt("com.google.dagger:hilt-android-compiler:2.48")
    //converter-gson
    implementation ("com.squareup.retrofit2:converter-gson:2.9.0")
    //Datastore
    implementation("androidx.datastore:datastore-preferences:1.0.0")
    //lottie
    implementation ("com.airbnb.android:lottie:6.4.0")
    //swipe refresh
    implementation(libs.androidx.swiperefreshlayout)
    //firebase
    implementation(platform("com.google.firebase:firebase-bom:33.0.0"))
    implementation(libs.androidx.navigation.fragment.ktx)
    implementation(libs.androidx.navigation.ui.ktx)
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)
}