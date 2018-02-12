//
//  UseCaseHandler.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

class UseCaseHandler {
    
    private let useCaseScheduler: UseCaseScheduler
    
    init(useCaseScheduler: UseCaseScheduler) {
        self.useCaseScheduler = useCaseScheduler
    }
    
    func executeUseCase<Rq: UseCaseRequest, Rs: UseCaseResponse>(useCase: UseCase<Rq, Rs>, request: Rq, success: @escaping (Rs) -> Void, error: @escaping () -> Void) {
        useCase.request = request
        useCase.success =  { (response: Rs) in
            self.notifyResponse(success: success, response: response)
        }
        useCase.error = {
            self.notifyError(error: error)
        }
        
        self.useCaseScheduler.execute {
            do {
                try useCase.run()
            } catch {
                print("UseCase execution failed: \(error)")
            }
        }
    }
    
    private func notifyResponse<Rs: UseCaseResponse>(success: @escaping (Rs) -> Void, response: Rs) {
        self.useCaseScheduler.execute {
            success(response)
        }
    }
    
    private func notifyError(error: @escaping () -> Void) {
        self.useCaseScheduler.notifyError {
            error()
        }
    }
    
}
