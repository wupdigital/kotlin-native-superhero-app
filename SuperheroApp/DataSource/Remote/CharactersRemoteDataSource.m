//
//  CharactersRemoteDataSource.m
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "CharactersRemoteDataSource.h"
#import "Character.h"
#import "NSString+MD5.h"
#import "Page.h"
#import <AFNetworking/AFNetworking.h>
#import <CommonCrypto/CommonDigest.h>

static const NSString * API_KEY = @"";
static const NSString * PRIVATE_KEY = @"";

@interface CharactersRemoteDataSource()

@property(nonatomic, strong, readonly) AFHTTPSessionManager *sessionManager;

@end

@implementation CharactersRemoteDataSource

- (instancetype)init {
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://gateway.marvel.com/"]];
    
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return [self initWithSessionManager:sessionManager];
}

- (instancetype)initWithSessionManager:(AFHTTPSessionManager *)sessionManager {
    self = [super init];
    
    if (self) {
        _sessionManager = sessionManager;
    }
    
    return self;
}

- (void)loadCharacter:(NSString *)characterId complete:(void (^)(Character *))complete error:(void (^)(void))error {

    NSString *url = [NSString stringWithFormat:@"v1/public/characters/%@", characterId];
    
    NSUInteger timestamp = [[NSDate new] timeIntervalSince1970];
    NSString *hash = [NSString stringWithFormat:@"%lu%@%@", (unsigned long)timestamp, PRIVATE_KEY, API_KEY];
    
    NSDictionary *parameters = @{
                                 @"apikey": API_KEY,
                                 @"ts": @(timestamp),
                                 @"hash": [hash md5]
                                 };
    
    [self.sessionManager GET: url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        NSLog(@"response %@", responseObject);
        
        NSDictionary *data = [responseObject valueForKey:@"data"];
        NSArray *results = [data valueForKey:@"results"];
        Character *character = nil;
        
        NSDictionary *item = [results firstObject];
        
        if (item != nil) {
            character = [Character new];
            character.name = [item valueForKey:@"name"];
            character.characterId = [item valueForKey:@"id"];
        }
        
        if (complete) {
            complete(character);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
        if (error) {
            error();
        }
    }];
}

- (void)loadCharacters:(Page *)page complete:(void (^)(NSArray<Character *> *))complete error:(void (^)(void))error {
 
    NSUInteger timestamp = [[NSDate new] timeIntervalSince1970];
    NSString *hash = [NSString stringWithFormat:@"%lu%@%@", (unsigned long)timestamp, PRIVATE_KEY, API_KEY];
    
    NSDictionary *parameters = @{
                                 @"limit": @(page.limit),
                                 @"offset": @(page.offset),
                                 @"apikey": API_KEY,
                                 @"ts": @(timestamp),
                                 @"hash": [hash md5]
                                 };
    
    [self.sessionManager GET:@"v1/public/characters" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"response %@", responseObject);
        
        NSDictionary *data = [responseObject valueForKey:@"data"];
        NSArray *results = [data valueForKey:@"results"];
        NSMutableArray<Character *> *characters = [NSMutableArray arrayWithCapacity:results.count];
        
        for (NSDictionary *item in results) {
            Character *character = [Character new];
            character.name = [item valueForKey:@"name"];
            character.characterId = [item valueForKey:@"id"];
            
            [characters addObject:character];
        }
        
        if (complete) {
            complete(characters);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
        NSLog(@"Error during load characters: %@", [err localizedDescription]);
        NSData *response = err.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        NSLog(@"Error response: %@", responseString);
        error();
    }];
}

- (void)saveCharacters:(NSArray<Character *> *)characters complete:(void (^)(void))complete error:(void (^)(void))error {
    complete();
}

@end
