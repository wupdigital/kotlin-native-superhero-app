//
//  UseCaseScheduler.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

protocol UseCaseScheduler {
    
    func execute(runnable: @escaping () -> Void)
    
    func notifyResponse(callback: @escaping (UseCaseResponse) -> Void, response: UseCaseResponse) -> Void
    
    func notifyError(callback: @escaping () -> Void)
}
