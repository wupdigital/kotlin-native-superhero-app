//
//  UseCaseScheduler.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

protocol UseCaseScheduler {

    func execute(runnable: @escaping () -> Void)

    func notifyResponse<Rs: UseCaseResponse>(callback: @escaping (Rs) -> Void, response: Rs)

    func notifyError(callback: @escaping () -> Void)
}
