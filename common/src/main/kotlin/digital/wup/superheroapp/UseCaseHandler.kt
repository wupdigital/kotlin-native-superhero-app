package digital.wup.superheroapp

class UseCaseHandler(val useCaseScheduler: UseCaseScheduler) {

    fun <Rq: UseCaseRequest, Rs: UseCaseResponse>executeUseCase(useCase: UseCase<Rq, Rs>, request: Rq, success: (Rs) -> Unit, error: () -> Unit) {
        useCase.request = request
        useCase.success = { response ->
            notifyResponse(success, response)
        }
        useCase.error = {
            notifyError(error)
        }

        useCaseScheduler.execute({
            try {
                useCase.run()
            } catch (e: Error) {
                print(e)
            }
        })
    }

    private fun <Rs: UseCaseResponse>notifyResponse(success: (Rs) -> Unit, response: Rs) {
        useCaseScheduler.notifyResponse(success, response)
    }

    private fun notifyError(error: () -> Unit) {
        useCaseScheduler.notifyError(error)
    }
}