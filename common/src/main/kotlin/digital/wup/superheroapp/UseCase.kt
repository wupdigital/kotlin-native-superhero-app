package digital.wup.superheroapp

interface UseCaseRequest

interface UseCaseResponse

abstract class UseCase<Rq: UseCaseRequest, Rs: UseCaseResponse> {

    lateinit var request: Rq
    lateinit var success: ((Rs) -> Unit)
    lateinit var error: (() -> Unit)

    fun run() {
        executeUseCase(request)
    }

    abstract fun executeUseCase(request: Rq)
}