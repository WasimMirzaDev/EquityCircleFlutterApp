// ✅ Add repositories inside buildscript
buildscript {
    repositories {
        google()       // ✅ Required for dependencies
        mavenCentral() // ✅ Required for dependencies
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.1.0") // Ensure correct placement
    }
}

// ✅ Ensure all projects have repositories
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ Fix build directory configuration
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// ✅ Properly define clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
