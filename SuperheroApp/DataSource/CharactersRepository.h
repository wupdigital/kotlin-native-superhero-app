//
//  CharactersRepository.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuperheroApp-Swift.h"

@interface CharactersRepository : NSObject<CharactersDataSource>

- (instancetype)initWithLocal:(id<CharactersDataSource>)localDataSource andRemote:(id<CharactersDataSource>)remoteDataSource NS_DESIGNATED_INITIALIZER;

@end
