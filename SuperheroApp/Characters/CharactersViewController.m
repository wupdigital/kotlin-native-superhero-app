//
//  CharactersViewController.m
//  SuperheroApp
//
//  Created by Balázs Varga on 2018. 01. 24..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "CharactersViewController.h"
#import "CharacterDetailViewController.h"
#import "SuperheroApp-Swift.h"
#import "CharactersPresenter.h"

@interface CharactersViewController ()

@property(atomic, strong) NSMutableArray<Character *> *objects;
@property(nonatomic, strong) id<CharactersMvpPresenter> presenter;
@property(nonatomic, strong) UIActivityIndicatorView *indicator;
@property(nonatomic, strong) UIActivityIndicatorView *loadMoreIndicator;

@end

@implementation CharactersViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.detailViewController = (CharacterDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loadMoreIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.tableView.backgroundView = self.indicator;
    self.tableView.tableFooterView = self.loadMoreIndicator;
    
    self.objects = [NSMutableArray array];
    self.presenter = [CharactersPresenter new];
    
    [self.presenter takeView:self];
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Character *object = self.objects[indexPath.row];
        CharacterDetailViewController *controller = (CharacterDetailViewController *)[[segue destinationViewController] topViewController];
        controller.characterId = [NSString stringWithFormat:@"%ld", (long)object.characterId];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Character *object = self.objects[indexPath.row];
    cell.textLabel.text = object.name;
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL lastItemReached = indexPath.row == self.objects.count - 1;
    
    if (lastItemReached) {
        [self.presenter loadMoreCharacters];
    }
}

- (void)setLoadingIndicator:(BOOL)active {
    if (active) {
        [self.indicator startAnimating];
    } else {
        [self.indicator stopAnimating];
    }
}

- (void)setMoreLoadingIndicator:(BOOL)active {
    if (active) {
        [self.loadMoreIndicator startAnimating];
    } else {
        [self.loadMoreIndicator stopAnimating];
    }
}

- (void)showCharacters:(NSArray *)characters {
    
    [self.objects addObjectsFromArray:characters];

    [self.tableView reloadData];
}

- (void)showNoCharacters {
    
}

- (void)showLoadingCharactersError:(NSString *)message {
    
}

@end
