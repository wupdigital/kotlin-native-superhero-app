package digital.wup.superhero.module.detail

import dagger.Subcomponent
import dagger.android.AndroidInjector
import digital.wup.android.presentation.ui.details.DetailsActivity

@Subcomponent
interface DetailActivitySubcomponent : AndroidInjector<DetailsActivity> {
    @Subcomponent.Builder
    abstract class Builder : AndroidInjector.Builder<DetailsActivity>()
}
