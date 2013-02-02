//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by lyonwj on 2/1/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"Deck.h"

@interface CardMatchingGame : NSObject
-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck*)deck;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card*)cardAtIndex:(NSUInteger)index;

-(void)resetGameStateWithCards:(NSUInteger)cardCount
                     usingDeck:(Deck*) deck;


@property (nonatomic, readonly) int score;
@property (strong, nonatomic) NSString* result;

@end
