//
//  UseCaseDelegate.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

@protocol UseCaseResponse;

@protocol UseCaseDelegate

- (void)onSuccess:(id<UseCaseResponse>)response;

- (void)onError;

@end
