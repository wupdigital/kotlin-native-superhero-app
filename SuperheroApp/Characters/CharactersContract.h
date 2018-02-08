//
//  CharactersContract.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MvpView.h"
#import "MvpPresenter.h"

@class Character;

@protocol CharactersMvpView <MvpView>

- (void)setLoadingIndicator:(BOOL)active;

- (void)showCharacters:(NSArray<Character *> *)characters;

- (void)showCharacterDetails:(NSString *)characterId;

- (void)showLoadingCharactersError:(NSString *)message;

- (void)showNoCharacters;

@end

@protocol CharactersMvpPresenter <MvpPresenter>

- (void)refreshCharacters;

- (void)loadCharacters;

- (void)loadMoreCharacters;

@end
