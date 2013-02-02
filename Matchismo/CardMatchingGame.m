//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by lyonwj on 2/1/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;

@end

@implementation CardMatchingGame

-(void)resetGameStateWithCards:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self.score = 0;
    self.result = [NSString stringWithFormat:@"Start flipping!"];
    self.cards = nil;
    for (int i=0; i<cardCount; i++)
    {
        Card *card = [deck drawRandomCard];
        self.cards[i]=card;
        
    }

    
}

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self)
    {
        for (int i=0; i<cardCount; i++)
        {
            Card *card = [deck drawRandomCard];
            if (!card)
            {
                self=nil;
            }
            
            else
            {
                self.cards[i]=card;
            }
        }
    }
    
    return self;
}

-(Card*)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable)
    {
        if (!card.isFaceUp)
        {
            // match card here
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore)
                    {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.result = [NSString stringWithFormat:@"MATCH: %@ / %@!!", card.contents, otherCard.contents];
                    }
                    else
                    {
                        otherCard.faceUP = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.result =[NSString stringWithFormat:@"%@ / %@ don't match!", card.contents, otherCard.contents];
                    }
                }
                
                else
                {
                   // self.result = [NSString stringWithFormat:@"Flipped up %@", card.contents];
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUP = !card.isFaceUp;
        
    }
}
@end
