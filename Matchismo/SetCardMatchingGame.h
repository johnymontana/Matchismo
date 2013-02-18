//
//  SetCardMatchingGame.h
//  Matchismo
//
//  Created by lyonwj on 2/15/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//
#import "SetCardDeck.h"
#import "CardMatchingGame.h"
#import "SetCard.h"

@interface SetCardMatchingGame : NSObject

-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(SetCardDeck*)deck;

-(void)flipCardAtIndex:(NSUInteger)index;

-(SetCard*)cardAtIndex:(NSUInteger)index;

-(void)resetGameStateWithCards:(NSUInteger)cardCount
                     usingDeck:(SetCardDeck*) deck;

@property (strong, nonatomic) NSMutableAttributedString* result;
@property (nonatomic, readonly) int score;
@end
