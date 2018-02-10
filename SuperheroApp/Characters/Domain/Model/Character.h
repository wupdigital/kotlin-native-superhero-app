//
//  Character.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property(nonatomic, strong) NSNumber *characterId;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *thumbnailUrl;

@end
