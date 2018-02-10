//
//  CharacterDetailViewController.m
//  SuperheroApp
//
//  Created by Balázs Varga on 2018. 01. 24..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "CharacterDetailViewController.h"
#import "Character.h"
#import "CharacterDetailContract.h"
#import "CharacterDetailPresenter.h"

@interface CharacterDetailViewController ()

@property(nonatomic, strong) id<CharacterDetailMvpPreseneter> presenter;

@end

@implementation CharacterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.presenter = [CharacterDetailPresenter new];
    [self.presenter takeView:self];
    [self loadContent];
}

- (void)loadContent {
    if (self.characterId != nil) {
        [self.presenter loadCharacter:self.characterId];
    }
}

- (void)showCharacter:(Character *)character {
    self.detailDescriptionLabel.text = character.name;
}

@end
