//
//  UseCase.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

enum UseCaseError: String, Error {
    case missingRequest = "Please set a request before execute an usecase"
    case executeUseCaseIsNotImplemented = "Please implement executeUseCase method"
}

protocol UseCaseRequest {

}

protocol UseCaseResponse {

}

class UseCase<Rq, Rs> where Rq: UseCaseRequest, Rs: UseCaseResponse {

    var request: Rq?
    var success: ((Rs) -> Void)?
    var error: (() -> Void)?

    final func run() throws {
        guard let request = self.request else {
            throw UseCaseError.missingRequest
        }
        try self.executeUseCase(request: request)
    }

    func executeUseCase(request: Rq) throws {
        throw UseCaseError.executeUseCaseIsNotImplemented
    }
}
