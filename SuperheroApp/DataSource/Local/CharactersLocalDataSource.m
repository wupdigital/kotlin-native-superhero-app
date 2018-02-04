//
//  CharactersLocalDataSource.m
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "CharactersLocalDataSource.h"
#import <CoreData/CoreData.h>
#import "Character.h"

@interface CharactersLocalDataSource()

@property(nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@end

@implementation CharactersLocalDataSource

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    self = [super init];
    
    if (self) {
        _managedObjectContext = managedObjectContext;
    }
    
    return self;
}

- (void)loadCharacter:(NSString *)characterId complete:(void (^)(Character *))complete error:(void (^)(void))error {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CharacterEntity"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id == %@", characterId]];

    NSError *err = nil;
    NSArray<NSManagedObject *> *data = [self.managedObjectContext executeFetchRequest:fetchRequest error:&err];
    
    if (err || data.count == 0) {
        error();
    } else {
        NSManagedObject *entity = [data firstObject];
        
        Character *character = [Character new];
        character.characterId = [entity valueForKey:@"id"];
        character.name = [entity valueForKey:@"name"];
        
        complete(character);
    }
}

- (void)loadCharacters:(NSUInteger)limit offset:(NSUInteger)offset complete:(void (^)(NSArray<Character *> *))complete error:(void (^)(void))error {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CharacterEntity"];
    
    NSError *err = nil;
    NSArray<NSManagedObject *> *data = [self.managedObjectContext executeFetchRequest:fetchRequest error:&err];
    
    if (err) {
        error();
    } else {
        NSMutableArray<Character *> *characters = [NSMutableArray new];
        
        for (NSManagedObject *entity in data) {
            Character *character = [Character new];
            character.characterId = [entity valueForKey:@"id"];
            character.name = [entity valueForKey:@"name"];
            
            [characters addObject:character];
        }
        
        complete(characters);
    }
}

- (void)saveCharacters:(NSArray<Character *> *)characters complete:(void (^)(void))complete error:(void (^)(void))error {
    NSError *err = nil;
    
    for (Character *character in characters) {
        NSManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterEntity" inManagedObjectContext:self.managedObjectContext];
        [entity setValue:character.characterId forKey:@"id"];
        [entity setValue:character.name forKey:@"name"];
    }
    
    if ([self.managedObjectContext save:&err] == NO) {
        error();
    } else {
        complete();
    }
}

@end
