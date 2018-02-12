//
//  Mvp.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

protocol MvpView {
    
}

protocol MvpPresenter {
    associatedtype ViewType where ViewType: MvpView
    
    func takeView(view: ViewType)
}
