package digital.wup.android.presentation.ui.characters

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import dagger.android.AndroidInjection
import digital.wup.android.R
import digital.wup.android.presentation.Navigation
import digital.wup.android.presentation.ui.details.DetailsActivity
import digital.wup.superheroapp.common.characters.CharactersMvpPresenter
import digital.wup.superheroapp.common.characters.CharactersMvpView
import digital.wup.superheroapp.common.characters.domain.model.Character
import javax.inject.Inject

class CharactersActivity : AppCompatActivity(), CharactersMvpView {

    @Inject
    internal lateinit var presenter: CharactersMvpPresenter

    private lateinit var recyclerView: RecyclerView

    override fun onCreate(savedInstanceState: Bundle?) {
        AndroidInjection.inject(this)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_superhero)

        recyclerView = findViewById(R.id.recyclerView)
        recyclerView.layoutManager = LinearLayoutManager(this)
        recyclerView.adapter = CharacterAdapter(onClick = { characterId ->
            navigateToDetails(characterId)
        })

        presenter.takeView(this)
    }

    override fun onDestroy() {
        super.onDestroy()
        presenter.dropView()
    }

    override fun showLoadingIndicator() {
    }

    override fun hideLoadingIndicator() {
    }

    override fun showMoreLoadingIndicator() {
    }

    override fun hideMoreLoadingIndicator() {
    }

    override fun showCharacters(characters: List<Character>) {
        (recyclerView.adapter as CharacterAdapter).addAll(characters)
    }

    override fun showLoadingCharactersError(message: String) {
    }

    override fun showNoCharacters() {
    }

    private fun navigateToDetails(characterId: String) {
        val args = Bundle()
        args.putString(Navigation.CHARACTER_ID, characterId)

        val navigate = Intent(this, DetailsActivity::class.java)
        navigate.putExtra(Navigation.EXTRA, args)
        startActivity(navigate)
    }
}
