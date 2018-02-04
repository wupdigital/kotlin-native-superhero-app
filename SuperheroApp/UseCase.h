//
//  UseCase.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UseCaseRequest;
@protocol UseCaseDelegate;

@interface UseCase : NSObject

@property(nonatomic, strong) id<UseCaseRequest> request;
@property(nonatomic, strong) id<UseCaseDelegate> useCaseDelegate;

- (void)run;

- (void)executeUseCase:(id<UseCaseRequest>) request;

@end
