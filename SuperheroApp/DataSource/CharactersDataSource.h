//
//  CharactersDataSource.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Character;

@protocol CharactersDataSource <NSObject>

- (void)loadCharacters:(NSUInteger)limit offset:(NSUInteger)offset complete:(void(^)(NSArray<Character *> *))complete error:(void(^)(void))error;

- (void)loadCharacter:(NSString *)characterId complete:(void(^)(Character *))complete error:(void(^)(void))error;;

- (void)saveCharacters:(NSArray<Character *> *)characters complete:(void(^)(void))complete error:(void(^)(void))error;

@end
