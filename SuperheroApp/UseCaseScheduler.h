//
//  UseCaseScheduler.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UseCaseResponse;
@protocol UseCaseDelegate;

@protocol UseCaseScheduler <NSObject>

- (void)execute:(void (^)(void))executable;

- (void)notifyResponse:(id<UseCaseDelegate>)useCaseDelegate of:(id<UseCaseResponse>)response;

- (void)notifyError:(id<UseCaseDelegate>)useCaseDelegate;

@end
