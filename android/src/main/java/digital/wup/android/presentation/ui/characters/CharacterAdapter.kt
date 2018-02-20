package digital.wup.android.presentation.ui.characters

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.TextView
import digital.wup.android.R
import digital.wup.superheroapp.common.characters.domain.model.Character

class CharacterAdapter(private val onClick: (String) -> Unit) : RecyclerView.Adapter<CharacterAdapter.ViewHolder>() {

    private var charactersDataSet: MutableList<Character> = mutableListOf()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.character_item, parent, false) as TextView
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.textView.text = charactersDataSet[holder.adapterPosition].name
        holder.textView.setOnClickListener {
            val characterId = charactersDataSet[holder.adapterPosition].characterId.toString()
            onClick(characterId)
        }
    }

    override fun getItemCount(): Int {
        return charactersDataSet.size
    }

    fun addAll(characters: List<Character>) {
        charactersDataSet.addAll(characters)
        notifyDataSetChanged()
    }

    class ViewHolder(var textView: TextView) : RecyclerView.ViewHolder(textView)
}