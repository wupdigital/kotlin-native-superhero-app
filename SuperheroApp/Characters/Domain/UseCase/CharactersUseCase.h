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
@class Page;
@protocol CharactersDataSource;

@interface CharactersUseCase : UseCase

- (instancetype)initWithDataSource:(id<CharactersDataSource>)charactersDataSource NS_DESIGNATED_INITIALIZER;

@end

@interface CharactersUseCaseRequest : NSObject<UseCaseRequest>

@property(nonatomic, strong) Page *page;

@end

@interface CharactersUseCaseResponse : NSObject<UseCaseResponse>

@property(nonatomic, strong) NSArray<Character *> *characters;

@end
