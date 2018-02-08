//
//  Page.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 08..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Page : NSObject

@property(nonatomic, assign) NSUInteger limit;
@property(nonatomic, assign) NSUInteger offset;

- (instancetype)initWithLimit:(NSUInteger)limit andOffset:(NSUInteger)offset;

@end
