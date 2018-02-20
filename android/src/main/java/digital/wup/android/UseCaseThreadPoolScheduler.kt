package digital.wup.android

import android.os.Handler
import android.os.Looper

import java.util.concurrent.ArrayBlockingQueue
import java.util.concurrent.ThreadPoolExecutor
import java.util.concurrent.TimeUnit

import digital.wup.superheroapp.common.UseCaseScheduler

class UseCaseThreadPoolScheduler : UseCaseScheduler {
    private val mHandler = Handler(Looper.getMainLooper())

    private var mThreadPoolExecutor: ThreadPoolExecutor

    init {
        mThreadPoolExecutor = ThreadPoolExecutor(POOL_SIZE, MAX_POOL_SIZE, TIMEOUT.toLong(),
                TimeUnit.SECONDS, ArrayBlockingQueue(POOL_SIZE))
    }

    companion object {

        val POOL_SIZE = 2

        val MAX_POOL_SIZE = 4

        val TIMEOUT = 30
    }

    override fun execute(runnable: () -> Unit) {
        mThreadPoolExecutor.execute(runnable)
    }

    override fun <Rs> notifyResponse(success: (Rs) -> Unit, response: Rs) {
        mHandler.post({ success(response) })
    }

    override fun notifyError(error: () -> Unit) {
        mHandler.post({ error() })
    }
}
