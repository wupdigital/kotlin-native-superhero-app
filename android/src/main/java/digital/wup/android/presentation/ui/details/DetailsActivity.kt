package digital.wup.android.presentation.ui.details

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.widget.ImageView
import android.widget.TextView
import com.squareup.picasso.Picasso
import dagger.android.AndroidInjection
import digital.wup.android.R
import digital.wup.android.presentation.Navigation
import digital.wup.superheroapp.common.characters.domain.model.Character

import digital.wup.superheroapp.common.charaterdetail.CharacterDetailMvpPresenter
import digital.wup.superheroapp.common.charaterdetail.CharacterDetailMvpView
import kotlinx.android.synthetic.main.activity_details.*
import javax.inject.Inject

open class DetailsActivity : AppCompatActivity(), CharacterDetailMvpView {

    @Inject
    internal lateinit var presenter: CharacterDetailMvpPresenter
    @Inject
    internal lateinit var picasso: Picasso

    override fun onCreate(savedInstanceState: Bundle?) {
        AndroidInjection.inject(this)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_details)

        val intent = intent
        val bundle = intent.getBundleExtra(Navigation.EXTRA)

        presenter.takeView(this)
        val characterId = bundle.getString(Navigation.CHARACTER_ID)
        presenter.loadCharacter(characterId.toInt())
    }


    override fun showCharacter(character: Character) {
        this.name.text = character.name

        picasso.load(character.thumbnailUrl + ".jpg").into(this.thumbnail)
    }

    override fun showNoCharacter() {

    }

    override fun showErrorMessage(message: String) {

    }
}
