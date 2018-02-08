//
//  UseCaseHandler.m
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "UseCaseHandler.h"

#import "UseCase.h"
#import "UseCaseDelegate.h"
#import "UseCaseScheduler.h"
#import "UseCaseNSOperationSheduler.h"

@interface UseCaseHandler()

@property(nonatomic, strong) id<UseCaseScheduler> useCaseSheduler;

- (void)notifyResponse:(id<UseCaseDelegate>)useCaseDelegate of:(id<UseCaseResponse>)response;

- (void)notifyError:(id<UseCaseDelegate>)useCaseDelegate;

@end

@interface UiDelegateWrapper : NSObject<UseCaseDelegate>

@property(nonatomic, strong) id<UseCaseDelegate> useCaseDelegate;
@property(nonatomic, strong) UseCaseHandler *useCaseHandler;

- (instancetype)initWithDelegate:(id<UseCaseDelegate>)useCaseDelegate and:(UseCaseHandler *)useCaseHandler;

@end

@implementation UiDelegateWrapper

- (instancetype)initWithDelegate:(id<UseCaseDelegate>)useCaseDelegate and:(UseCaseHandler *)useCaseHandler {
    self = [super init];
    
    if (self) {
        self.useCaseDelegate = useCaseDelegate;
        self.useCaseHandler = useCaseHandler;
    }
    
    return self;
}

- (void)onSuccess:(id<UseCaseResponse>)response {
    [self.useCaseHandler notifyResponse:self.useCaseDelegate of:response];
}

- (void)onError {
    [self.useCaseHandler notifyError:self.useCaseDelegate];
}

@end

@implementation UseCaseHandler

- (instancetype)init {
    return [self initWithScheduler:[[UseCaseNSOperationSheduler alloc] init]];
}

- (instancetype)initWithScheduler:(id<UseCaseScheduler>)scheduler {
    self = [super init];
    
    if (self) {
        self.useCaseSheduler = scheduler;
    }
    
    return self;
}

- (void)execute:(UseCase *)useCase withRequest:(id<UseCaseRequest>)request and:(id<UseCaseDelegate>)useCaseDelegate {
    useCase.request = request;
    useCase.useCaseDelegate = [[UiDelegateWrapper alloc] initWithDelegate:useCaseDelegate and:self];
    
    [self.useCaseSheduler execute:^{
        [useCase run];
    }];
}

- (void)notifyResponse:(id<UseCaseDelegate>)useCaseDelegate of:(id<UseCaseResponse>)response {
    [self.useCaseSheduler notifyResponse:useCaseDelegate of:response];
}

- (void)notifyError:(id<UseCaseDelegate>)useCaseDelegate {
    [self.useCaseSheduler notifyError:useCaseDelegate];
}

@end

