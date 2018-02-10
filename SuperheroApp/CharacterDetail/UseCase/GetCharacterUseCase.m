//
//  GetCharacterUseCase.m
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 10..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "GetCharacterUseCase.h"
#import "CharactersDataSource.h"
#import "CharactersRepository.h"
#import "UseCaseDelegate.h"

@interface GetCharacterUseCase()

@property(nonatomic, strong) id<CharactersDataSource> charactersDataSource;

@end

@implementation GetCharacterUseCase

- (instancetype)init {
    return [self initWithDataSource:[CharactersRepository new]];
}

- (instancetype)initWithDataSource:(id<CharactersDataSource>)dataSource {
    self = [super init];
    
    if (self) {
        self.charactersDataSource = dataSource;
    }
    
    return self;
}

- (void)executeUseCase:(id<UseCaseRequest>)request {
    NSAssert([request isKindOfClass:[GetCharacterRequest class]], @"Use case request must be an instance of GetCharacterRequest class");
    
    GetCharacterRequest *characterRequest = (GetCharacterRequest *)request;
    
    [self.charactersDataSource loadCharacter:characterRequest.characterId complete:^(Character *character) {
        GetCharacterResponse *response = [GetCharacterResponse new];
        response.character = character;
        [self.useCaseDelegate onSuccess:response];
    } error:^{
        [self.useCaseDelegate onError];
    }];
}

@end

@implementation GetCharacterRequest

@end

@implementation GetCharacterResponse

@end
