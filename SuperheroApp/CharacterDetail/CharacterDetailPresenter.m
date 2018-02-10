//
//  CharacterDetailPresenter.m
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 09..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "CharacterDetailPresenter.h"
#import "GetCharacterUseCase.h"
#import "UseCaseHandler.h"
#import "UseCaseDelegate.h"

@interface CharacterDetailPresenter() <UseCaseDelegate>

@property(nonatomic, weak) id<CharacterDetailMvpView> view;
@property(nonatomic, strong) UseCaseHandler *useCaseHandler;

@end

@implementation CharacterDetailPresenter

- (instancetype)init {
    return [self initWithUseCaseHandler:[UseCaseHandler new]];
}

- (instancetype)initWithUseCaseHandler:(UseCaseHandler *)useCaseHandler {
    self = [super init];
    
    if (self) {
        self.useCaseHandler = useCaseHandler;
    }
    
    return self;
}

- (void)takeView:(id<MvpView>)view {
    self.view = (id<CharacterDetailMvpView>)view;
}

- (void)loadCharacter:(NSString *)characterId {
    
    GetCharacterRequest *request = [GetCharacterRequest new];
    request.characterId = characterId;
    
    [self.useCaseHandler execute:[GetCharacterUseCase new] withRequest:request and:self];
}

- (void)onError {
    
}

- (void)onSuccess:(id<UseCaseResponse>)response {
    GetCharacterResponse *characterResponse = (GetCharacterResponse *)response;
    [self.view showCharacter:characterResponse.character];
}

@end
