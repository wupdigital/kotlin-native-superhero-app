//
//  UseCaseNSOperationSheduler.m
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "UseCaseNSOperationSheduler.h"

#import "UseCaseDelegate.h"

@interface UseCaseNSOperationSheduler()

@property(nonatomic, retain) NSOperationQueue *queue;
@property(nonatomic, retain) NSOperationQueue *mainQueue;

@end

@implementation UseCaseNSOperationSheduler

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.queue = [[NSOperationQueue alloc] init];
        self.mainQueue = [NSOperationQueue mainQueue];
    }
    
    return self;
}

- (void)execute:(void (^)(void))executable {
    [self.queue addOperationWithBlock:executable];
}

- (void)notifyError:(id<UseCaseDelegate>)useCaseDelegate {
    [self.mainQueue addOperationWithBlock:^{
        [useCaseDelegate onError];
    }];
}

- (void)notifyResponse:(id<UseCaseDelegate>)useCaseDelegate of:(id<UseCaseResponse>)response {
    [self.mainQueue addOperationWithBlock:^{
        [useCaseDelegate onSuccess:response];
    }];
}

@end
