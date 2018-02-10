//
//  CharacterDetailViewController.h
//  SuperheroApp
//
//  Created by Balázs Varga on 2018. 01. 24..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterDetailContract.h"

@class Character;

@interface CharacterDetailViewController : UIViewController<CharacterDetailMvpView>

@property (strong, nonatomic) NSString *characterId;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;

@end
