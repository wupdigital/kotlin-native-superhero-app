//
//  UseCase.m
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "UseCase.h"

@implementation UseCase

- (void)run {
    [self executeUseCase:self.request];
}

- (void)executeUseCase:(id<UseCaseRequest>)request {
    [self doesNotRecognizeSelector:_cmd];
}

@end
