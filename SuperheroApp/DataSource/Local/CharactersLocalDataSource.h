//
//  CharactersLocalDataSource.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharactersDataSource.h"

@class NSManagedObjectContext;

@interface CharactersLocalDataSource : NSObject<CharactersDataSource>

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext NS_DESIGNATED_INITIALIZER;

@end
