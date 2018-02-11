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

static const NSUInteger DEFAULT_LIMIT = 100;

@interface CharactersPresenter() <UseCaseDelegate>

@property(nonatomic, weak) id<CharactersMvpView> view;
@property(nonatomic, strong) UseCaseHandler *useCaseHandler;
@property(nonatomic, strong) Page *currentPage;

@end

@implementation CharactersPresenter

- (instancetype)init {
    return [self initWithUseCaseHandler:[UseCaseHandler new]];
}

- (instancetype)initWithUseCaseHandler:(UseCaseHandler *)useCaseHandler {
    self = [super init];
    
    if (self) {
        self.useCaseHandler = useCaseHandler;
        self.currentPage = [[Page alloc] initWithLimit:DEFAULT_LIMIT andOffset:0];
    }
    
    return self;
}

- (void)takeView:(id<MvpView>)view {
    self.view = (id<CharactersMvpView>)view;
    [self loadCharacters];
}

- (void)loadCharacters {
    
    [self.view setLoadingIndicator:YES];
    self.currentPage = [[Page alloc] initWithLimit:DEFAULT_LIMIT andOffset:0];
    CharactersUseCaseRequest *request = [CharactersUseCaseRequest new];
    request.page = self.currentPage;
    
    [self.useCaseHandler execute:[CharactersUseCase new] withRequest:request and:self];
}

- (void)loadMoreCharacters {
    
    [self.view setMoreLoadingIndicator:YES];
    self.currentPage.offset += DEFAULT_LIMIT;
    CharactersUseCaseRequest *request = [CharactersUseCaseRequest new];
    request.page = self.currentPage;
    
    [self.useCaseHandler execute:[CharactersUseCase new] withRequest:request and:self];
}

- (void)onError {
    [self stopLoading];
    [self.view showLoadingCharactersError:@"Something wrong"];
}

- (void)onSuccess:(id<UseCaseResponse>)response {
    CharactersUseCaseResponse *charactersResponse = (CharactersUseCaseResponse *)response;
    
    [self stopLoading];
    
    if (charactersResponse.characters.count > 0) {
        [self.view showCharacters:charactersResponse.characters];
    }
}

- (void)stopLoading {
    if (self.currentPage.offset == 0) {
        [self.view setLoadingIndicator:NO];
    } else {
        [self.view setMoreLoadingIndicator:NO];
    }
}

@end
