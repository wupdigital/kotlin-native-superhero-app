//
//  Page.m
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 08..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "Page.h"

@implementation Page

- (instancetype)initWithLimit:(NSUInteger)limit andOffset:(NSUInteger)offset {
    self = [self init];
    
    if (self) {
        self.limit = limit;
        self.offset = offset;
    }
    
    return self;
}

@end
