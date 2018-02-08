//
//  CharactersLocalDataSource.m
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "CharactersLocalDataSource.h"
#import "Character.h"
#import "Page.h"
#import <CoreData/CoreData.h>

@interface CharactersLocalDataSource()

@property(nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@end

@implementation CharactersLocalDataSource

- (instancetype)init {
    return [self initWithManagedObjectContext:[CharactersLocalDataSource managedObjectContext]];
}

+ (NSManagedObjectContext *)managedObjectContext {
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    managedObjectContext.persistentStoreCoordinator = coordinator;
    return managedObjectContext;
}

+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CharactersEntity.sqlite"];
    
    NSError *error = nil;
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return persistentStoreCoordinator;
}

+ (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSManagedObjectModel *)managedObjectModel {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CharacterModel" withExtension:@"momd"];
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
}

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
        if (error != nil) {
            error();
        }
    } else {
        NSManagedObject *entity = [data firstObject];
        
        Character *character = [Character new];
        character.characterId = [entity valueForKey:@"id"];
        character.name = [entity valueForKey:@"name"];
        
        if (complete != nil) {
            complete(character);
        }
    }
}

- (void)loadCharacters:(Page *)page complete:(void (^)(NSArray<Character *> *))complete error:(void (^)(void))error {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CharacterEntity"];
    
    NSError *err = nil;
    NSArray<NSManagedObject *> *data = [self.managedObjectContext executeFetchRequest:fetchRequest error:&err];
    
    if (err || data.count == 0) {
        if (error != nil) {
            error();
        }
    } else {
        NSMutableArray<Character *> *characters = [NSMutableArray new];
        
        for (NSManagedObject *entity in data) {
            Character *character = [Character new];
            character.characterId = [entity valueForKey:@"id"];
            character.name = [entity valueForKey:@"name"];
            
            [characters addObject:character];
        }
        
        if (complete != nil) {
            complete(characters);
        }
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
        if (error != nil) {
            error();
        }
    } else {
        if (complete != nil) {
            complete();
        }
    }
}

@end
