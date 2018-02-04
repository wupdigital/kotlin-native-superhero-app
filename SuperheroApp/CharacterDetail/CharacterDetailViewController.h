//
//  CharacterDetailViewController.h
//  SuperheroApp
//
//  Created by Balázs Varga on 2018. 01. 24..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MvpView.h"

@interface CharacterDetailViewController : UIViewController<MvpView>

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

