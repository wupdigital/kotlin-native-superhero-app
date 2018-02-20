package digital.wup.android.module.detail

import android.app.Activity
import dagger.Binds
import dagger.Module
import dagger.android.ActivityKey
import dagger.android.AndroidInjector
import dagger.multibindings.IntoMap
import digital.wup.android.presentation.ui.details.DetailsActivity
import digital.wup.superhero.module.detail.DetailActivitySubcomponent

@Module(subcomponents = arrayOf(DetailActivitySubcomponent::class))
abstract class DetailActivityModule {
    @Binds
    @IntoMap
    @ActivityKey(DetailsActivity::class)
    internal abstract fun bindDetailsActivityInjectorFactory(builder: DetailActivitySubcomponent.Builder): AndroidInjector.Factory<out Activity>
}
