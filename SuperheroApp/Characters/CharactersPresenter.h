//
//  CharactersPresenter.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "CharactersContract.h"

@class UseCaseHandler;

@interface CharactersPresenter : NSObject<CharactersMvpPresenter>

- (instancetype)initWithUseCaseHandler:(UseCaseHandler *)useCaseHandler NS_DESIGNATED_INITIALIZER;

@end
