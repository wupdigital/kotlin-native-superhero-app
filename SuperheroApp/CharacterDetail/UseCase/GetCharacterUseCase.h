//
//  GetCharacterUseCase.h
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 10..
//  Copyright © 2018. W.UP. All rights reserved.
//

@protocol CharactersDataSource;
@class Character;

@interface GetCharacterUseCase : UseCase

- (instancetype)initWithDataSource:(id<CharactersDataSource>)dataSource NS_DESIGNATED_INITIALIZER;

@end

@interface GetCharacterRequest : NSObject <UseCaseRequest>

@property(nonatomic, strong) NSString *characterId;

@end

@interface GetCharacterResponse : NSObject <UseCaseResponse>

@property(nonatomic, strong) Character *character;

@end
