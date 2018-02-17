//
//  UseCaseNSOperationQueueScheduler.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Common
import Foundation

class UseCaseNSOperationQueueScheduler: NSObject, CommonUseCaseScheduler {

    private var workerQueue: OperationQueue
    private var mainQueue: OperationQueue

    convenience override init() {
        self.init(workerQueue: OperationQueue(), mainQueue: OperationQueue.main)
    }

    init(workerQueue: OperationQueue, mainQueue: OperationQueue) {
        self.workerQueue = workerQueue
        self.mainQueue = mainQueue
    }

    func execute(runnable: @escaping () -> CommonStdlibUnit) {
        workerQueue.addOperation {
            _ = runnable()
        }
    }

    func notifyResponse(success: @escaping (Any?) -> CommonStdlibUnit, response: Any?) {
        mainQueue.addOperation {
            _ = success(response)
        }
    }

    func notifyError(error: @escaping () -> CommonStdlibUnit) {
        mainQueue.addOperation {
            _ = error()
        }
    }
}
