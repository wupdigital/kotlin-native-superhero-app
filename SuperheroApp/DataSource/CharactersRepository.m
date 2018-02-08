//
//  CharactersRepository.m
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "CharactersRepository.h"
#import "CharactersLocalDataSource.h"
#import "CharactersRemoteDataSource.h"

@interface CharactersRepository()

@property(nonatomic, strong) id<CharactersDataSource> localDataSource;
@property(nonatomic, strong) id<CharactersDataSource> remoteDataSource;

@end

@implementation CharactersRepository

- (instancetype)init {
    return [self initWithLocal:[CharactersLocalDataSource new] andRemote:[CharactersRemoteDataSource new]];
}

- (instancetype)initWithLocal:(id<CharactersDataSource>)localDataSource andRemote:(id<CharactersDataSource>)remoteDataSource {
    self = [super self];
    
    if (self) {
        self.localDataSource = localDataSource;
        self.remoteDataSource = remoteDataSource;
    }
    
    return self;
}

- (void)loadCharacter:(NSString *)characterId complete:(void (^)(Character *))complete error:(void (^)(void))error {
    [self.localDataSource loadCharacter:characterId complete:complete error:^{
        [self.remoteDataSource loadCharacter:characterId complete:complete error:error];
    }];
}

- (void)loadCharacters:(NSUInteger)limit offset:(NSUInteger)offset complete:(void (^)(NSArray<Character *> *))complete error:(void (^)(void))error {
    [self.localDataSource loadCharacters:limit offset:offset complete:^(NSArray<Character *> *characters) {
        if (complete) {
            complete(characters);
        }
    } error:^{
        [self.remoteDataSource loadCharacters:limit offset:offset complete:^(NSArray<Character *> *characters) {
            [self.localDataSource saveCharacters:characters complete:nil error:nil];
            if (complete) {
                complete(characters);
            }
        } error:error];
    }];
}

- (void)saveCharacters:(NSArray<Character *> *)characters complete:(void (^)(void))complete error:(void (^)(void))error{
    [self.localDataSource saveCharacters:characters complete:^{
        [self.remoteDataSource saveCharacters:characters complete:complete error:error];
    } error:^{
        [self.remoteDataSource saveCharacters:characters complete:complete error:error];
    }];
}

@end
