//
//  CharactersPresenter.m
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "CharactersPresenter.h"
#import "CharactersUseCase.h"
#import "Page.h"
#import "UseCaseHandler.h"
#import "UseCaseDelegate.h"

@interface CharactersPresenter() <UseCaseDelegate>

@property(nonatomic, weak) id<CharactersMvpView> view;
@property(nonatomic, strong) UseCaseHandler *useCaseHandler;

@end

@implementation CharactersPresenter

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
    self.view = (id<CharactersMvpView>)view;
    [self loadCharacters];
}

- (void)dropView {
    self.view = nil;
}

- (void)refreshCharacters {
    // TODO implement
}

- (void)loadCharacters {
    
    [self.view setLoadingIndicator:YES];
    
    CharactersUseCaseRequest *request = [CharactersUseCaseRequest new];
    request.page = [[Page alloc] initWithLimit:100 andOffset:0];
    
    [self.useCaseHandler execute:[CharactersUseCase new] withRequest:request and:self];
}

- (void)loadMoreCharacters {
    // TODO implement
}

- (void)onError {
    [self.view setLoadingIndicator:NO];
    [self.view showLoadingCharactersError:@"Something wrong"];
}

- (void)onSuccess:(id<UseCaseResponse>)response {
    CharactersUseCaseResponse *charactersResponse = (CharactersUseCaseResponse *)response;
    
    [self.view setLoadingIndicator:NO];
    [self.view showCharacters:charactersResponse.characters];
}

@end
