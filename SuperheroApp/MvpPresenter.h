//
//  MvpPresenter.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MvpView;

@protocol MvpPresenter<NSObject>

- (void)takeView:(id<MvpView>) view;

- (void)dropView;

@end
