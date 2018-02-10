//
//  CharacterDetailPresenter.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 09..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "CharacterDetailContract.h"

@class UseCaseHandler;

@interface CharacterDetailPresenter : NSObject<CharacterDetailMvpPreseneter>

- (instancetype)initWithUseCaseHandler:(UseCaseHandler *)useCaseHandler NS_DESIGNATED_INITIALIZER;

@end
