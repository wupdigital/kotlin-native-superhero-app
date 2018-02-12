//
//  UseCaseNSOperationQueueScheduler.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

class UseCaseNSOperationQueueScheduler: UseCaseScheduler {
    
    private var workerQueue: OperationQueue
    private var mainQueue: OperationQueue
    
    convenience init() {
        self.init(workerQueue: OperationQueue(), mainQueue: OperationQueue.main)
    }
    
    init(workerQueue: OperationQueue, mainQueue: OperationQueue) {
        self.workerQueue = workerQueue
        self.mainQueue = mainQueue
    }
    
    func execute(runnable: @escaping () -> Void) {
        self.workerQueue.addOperation {
            runnable()
        }
    }
    
    func notifyResponse(callback: @escaping (UseCaseResponse) -> Void, response: UseCaseResponse) {
        self.mainQueue.addOperation {
            callback(response)
        }
    }
    
    func notifyError(callback: @escaping () -> Void) {
        self.mainQueue.addOperation {
            callback()
        }
    }
}
