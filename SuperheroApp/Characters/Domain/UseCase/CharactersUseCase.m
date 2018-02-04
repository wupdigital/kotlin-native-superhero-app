//
//  CharactersUseCase.m
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "CharactersUseCase.h"
#import "CharactersDataSource.h"
#import "UseCaseDelegate.h"

@interface CharactersUseCase()

@property(nonatomic, retain) id<CharactersDataSource> charactersDataSource;

@end

@implementation CharactersUseCase

- (instancetype)initWithDataSource:(id<CharactersDataSource>)charactersDataSource {
    self = [super init];
    
    if (self) {
        self.charactersDataSource = charactersDataSource;
    }
    
    return self;
}

- (void)executeUseCase:(id<UseCaseRequest>)request {
    NSAssert([request isKindOfClass:[CharactersUseCaseRequest class]], @"Use case request must be an instance of CharactersUseCaseRequest class");
    
    CharactersUseCaseRequest *charactersRequest = (CharactersUseCaseRequest *)request;
    
    [self.charactersDataSource loadCharacters:charactersRequest.limit offset:charactersRequest.offset complete:^(NSArray<Character *> *characters) {
        [self onCharactersLoaded:characters];
    } error:^{
        [self onCharactersNotLoaded];
    }];
    
}

- (void)onCharactersLoaded:(NSArray<Character *> *)characters {
    CharactersUseCaseResponse * response = [CharactersUseCaseResponse new];
    response.characters = characters;
    [self.useCaseDelegate onSuccess:response];
}

- (void)onCharactersNotLoaded {
    [self.useCaseDelegate onError];
}

@end

@implementation CharactersUseCaseRequest

@end

@implementation CharactersUseCaseResponse

@end
