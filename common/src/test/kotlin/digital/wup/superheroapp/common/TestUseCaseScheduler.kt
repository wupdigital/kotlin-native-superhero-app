package digital.wup.superheroapp.common

/**
 * @author Balazs Varga
 */
class TestUseCaseScheduler : UseCaseScheduler {

    override fun execute(runnable: () -> Unit) {
        runnable()
    }

    override fun <Rs> notifyResponse(success: (Rs) -> Unit, response: Rs) {
        success(response)
    }

    override fun notifyError(error: () -> Unit) {
        error()
    }
}