package digital.wup.superheroapp.mvp

interface MvpView

interface MvpPresenter<View: MvpView> {
    fun takeView(view: View)

    fun dropView()
}