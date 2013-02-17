//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by lyonwj on 2/1/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;    // cards in the current game
@property (nonatomic) int score;                        // current match score

@end

@implementation CardMatchingGame

-(void)resetGameStateWithCards:(NSUInteger)cardCount usingDeck:(Deck *)deck     // add random cards to game
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
    if (!_cards) _cards = [[NSMutableArray alloc] init];                    // lazy instantiation
    return _cards;  
}

-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck         // init add random cards to game
{
    self = [super init];
    
    if (self)
    {
        for (int i=0; i<cardCount; i++)
        {
            Card *card = [deck drawRandomCard];
            NSLog(@"Just drew a: %@", card.contents);
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

-(void)flipCardAtIndex:(NSUInteger)index        // flip card and match against any other faceup & playable cards
{                                               // depending on 2 or 3 card matching mode, set self.score (match score)
                                                // and self.result (result text for flip)
    Card *card = [self cardAtIndex:index];
   // NSMutableArray *faceUpCards = [[NSMutableArray alloc] init];
    
    if (!self.three_card_match_mode)   // if in two card matching mode
    {
        if (!card.isUnplayable)
        {
            if (!card.isFaceUp)
            {
                // match card here
                self.result = [NSString stringWithFormat:@"Flipped: %@", card.contents];
                for (Card *otherCard in self.cards)
                {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable)
                    {
                        // add all other cards that are faceUp and Playable into an array and match on this array
                        
                        
                        
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
    else // three card matching mode
    {
        // TODO
        // get card at index
        // get all other other faceUp && !Unplayable cards
        // if length of all other faceUP&& !Unplayable cards == 2, then match on this array
        NSLog(@"Three card mode selected");
        NSMutableArray *faceUpCards = [[NSMutableArray alloc] init];
        
        if (!card.isUnplayable)
        {
            if (!card.isFaceUp)
            {
                self.result = [NSString stringWithFormat:@"Flipped: %@", card.contents];    // Show card being flipped
                for (Card *otherCard in self.cards)
                {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable)
                    {
                        [faceUpCards addObject:otherCard];
                    }
                    
                    if (faceUpCards.count==2)
                    {
                       // NSString* resultText = [[NSString alloc] init];
                        int matchScore = [card match:faceUpCards];
                        if (matchScore)
                        {
                            // TODO: set all other cards to unplayable
                            
                         //   resultText=[NSString stringWithFormat:@" "];
                            for (Card *otherCard in faceUpCards)
                            {
                                otherCard.unplayable = YES;
                           //     [resultText stringByAppendingFormat:@"%@", otherCard.contents];
                            }
                            card.unplayable = YES;
                            self.score += matchScore * MATCH_BONUS;
                            Card* otherCard1 = faceUpCards[0];
                            Card* otherCard2 = faceUpCards[1];
                            
                            self.result = [NSString stringWithFormat:@"MATCH: %@ / %@ / %@!!", card.contents, otherCard1.contents, otherCard2.contents];
                        }
                        else
                        {
                            // TODO: set all other cards to faceUP=NO
                            
                            for (Card *otherCard in faceUpCards)
                            {
                                otherCard.faceUP = NO;
                            }
                            self.score -= MISMATCH_PENALTY;
                            Card* otherCard1 = faceUpCards[0];
                            Card* otherCard2 = faceUpCards[1];
                            
                            self.result = [NSString stringWithFormat:@"NO MATCH: %@ / %@ / %@", card.contents, otherCard1.contents, otherCard2.contents];
                            
                        }
                    }
                }
                self.score -= FLIP_COST;
            }
            card.faceUP = !card.isFaceUp;
            faceUpCards=nil;
        }
    }
}
@end
