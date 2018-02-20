package digital.wup.android


import android.app.Activity
import android.app.Application
import android.content.Context
import android.support.multidex.MultiDex

import javax.inject.Inject

import dagger.android.AndroidInjector
import dagger.android.DispatchingAndroidInjector
import dagger.android.HasActivityInjector
import digital.wup.superhero.module.SuperheroModule
import io.objectbox.BoxStore
import timber.log.Timber

class SuperheroApp : Application(), HasActivityInjector {
    @Inject
    internal lateinit var dispatchingActivityInjector: DispatchingAndroidInjector<Activity>

    lateinit var boxStore: BoxStore

    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }

    override fun onCreate() {
        super.onCreate()
        boxStore = MyObjectBox.builder().androidContext(this).build()
        DaggerSuperheroComponent.builder()
                .superheroModule(SuperheroModule(this))
                .build()
                .inject(this)
        Timber.plant(Timber.DebugTree())
    }

    override fun activityInjector(): AndroidInjector<Activity>? {
        return dispatchingActivityInjector
    }
}
