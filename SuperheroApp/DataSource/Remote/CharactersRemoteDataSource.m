//
//  CharactersRemoteDataSource.m
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 04..
//  Copyright © 2018. W.UP. All rights reserved.
//

#import "CharactersRemoteDataSource.h"
#import "NSString+MD5.h"
#import "SuperheroApp-Swift.h"
#import <AFNetworking/AFNetworking.h>
#import <CommonCrypto/CommonDigest.h>

#define PUBLIC_API_KEY      [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MarvelPublicApiKey"]
#define PRIVATE_API_KEY     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MarvelPrivateApiKey"]

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
    NSString *hash = [NSString stringWithFormat:@"%lu%@%@", (unsigned long)timestamp, PRIVATE_API_KEY, PUBLIC_API_KEY];
    
    NSDictionary *parameters = @{
                                 @"apikey": PUBLIC_API_KEY,
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
            character = [self extractCharacterFromJsonDisctionary:item];
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
    NSString *hash = [NSString stringWithFormat:@"%lu%@%@", (unsigned long)timestamp, PRIVATE_API_KEY, PUBLIC_API_KEY];
    
    NSDictionary *parameters = @{
                                 @"limit": @(page.limit),
                                 @"offset": @(page.offset),
                                 @"apikey": PUBLIC_API_KEY,
                                 @"ts": @(timestamp),
                                 @"hash": [hash md5]
                                 };
    
    [self.sessionManager GET:@"v1/public/characters" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"response %@", responseObject);
        
        NSDictionary *data = [responseObject valueForKey:@"data"];
        NSArray *results = [data valueForKey:@"results"];
        NSMutableArray<Character *> *characters = [NSMutableArray arrayWithCapacity:results.count];
        
        for (NSDictionary *item in results) {
            
            Character *character = [self extractCharacterFromJsonDisctionary:item];
    
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

- (Character *)extractCharacterFromJsonDisctionary:(NSDictionary *)item {
    Character *character = [Character new];
    character.name = [item valueForKey:@"name"];
    character.characterId = [item valueForKey:@"id"];
    
    NSDictionary *thumbnail = [item valueForKey:@"thumbnail"];
    NSString *thumbnailUrl = [NSString stringWithFormat:@"%@.%@", [thumbnail valueForKey:@"path"], [thumbnail valueForKey:@"extension"]];
    character.thumbnailUrl = [thumbnailUrl stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    
    return character;
}

@end
