//
//  CharacterDetailContract.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 09..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "MvpView.h"
#import "MvpPresenter.h"

@class Character;

@protocol CharacterDetailMvpView <MvpView>

- (void)showCharacter:(Character *)character;

@end

@protocol CharacterDetailMvpPreseneter <MvpPresenter>

- (void)loadCharacter:(NSString *)characterId;

@end
