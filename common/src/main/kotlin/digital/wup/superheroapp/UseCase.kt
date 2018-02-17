package digital.wup.superheroapp

open class UseCase<Rq: UseCaseRequest, Rs: UseCaseResponse> {

    lateinit var request: Rq
    lateinit var success: ((Rs) -> Unit)
    lateinit var error: (() -> Unit)

    fun run() {
        executeUseCase(request)
    }

    open fun executeUseCase(request: Rq) {}
}