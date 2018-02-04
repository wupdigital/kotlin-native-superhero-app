//
//  CharactersUseCase.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UseCase.h"
#import "UseCaseRequest.h"
#import "UseCaseResponse.h"

@class Character;
@protocol CharactersDataSource;

@interface CharactersUseCase : UseCase

- (instancetype)initWithDataSource:(id<CharactersDataSource>)charactersDataSource;

@end

@interface CharactersUseCaseRequest : NSObject<UseCaseRequest>

@property(nonatomic, assign) NSUInteger limit;
@property(nonatomic, assign) NSUInteger offset;

@end

@interface CharactersUseCaseResponse : NSObject<UseCaseResponse>

@property(nonatomic, strong) NSArray<Character *> *characters;

@end
