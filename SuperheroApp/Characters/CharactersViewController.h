//
//  CharactersViewController.h
//  SuperheroApp
//
//  Created by Balázs Varga on 2018. 01. 24..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MvpView.h"

@class CharacterDetailViewController;

@interface CharactersViewController : UITableViewController <MvpView>

@property (strong, nonatomic) CharacterDetailViewController *detailViewController;


@end

