//
//  SetCardMatchingGame.m
//  Matchismo
//
//  Created by lyonwj on 2/15/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "SetCardMatchingGame.h"
#import "SetCard.h"

@interface SetCardMatchingGame()
@property (strong, nonatomic) NSMutableArray* cards;
@property (nonatomic) int score;
@end


@implementation SetCardMatchingGame

#define FLIP_COST 1
#define MATCH_BONUS 7
#define MISMATCH_PENALTY 5

-(void)flipCardAtIndex:(NSUInteger)index
{
    SetCard *card  = [self cardAtIndex:index];
    // TODO: 3-card matching mode only - see CardMatchingGame flipCardAtIndex:
    NSMutableArray *faceUpCards = [[NSMutableArray alloc] init];
    
    if (!card.isUnplayable)
    {
        if (!card.isFaceUp)
        {
            self.result = [NSString stringWithFormat:@"Flipped: %@", card.contents];    // Show card being flipped
            for (SetCard *otherCard in self.cards)
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
                        for (SetCard *otherCard in faceUpCards)
                        {
                            otherCard.unplayable = YES;
                            //     [resultText stringByAppendingFormat:@"%@", otherCard.contents];
                        }
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        SetCard* otherCard1 = faceUpCards[0];
                        SetCard* otherCard2 = faceUpCards[1];
                        
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
                        SetCard* otherCard1 = faceUpCards[0];
                        SetCard* otherCard2 = faceUpCards[1];
                        
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

-(NSMutableArray*) cards
{
    if (!_cards) _cards =[[NSMutableArray alloc] init];
    return _cards;

}

-(SetCard*)cardAtIndex:(NSUInteger)index
{
   return (index < self.cards.count) ? self.cards[index] : nil;
}

-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(SetCardDeck *)deck         // init add random cards to game
{
    self = [super init];
    
    if (self)
    {
        for (int i=0; i<cardCount; i++)
        {
            SetCard *card = [deck drawRandomCard];
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

-(void)resetGameStateWithCards:(NSUInteger)cardCount usingDeck:(SetCardDeck *)deck     // add random cards to game
{
    //self.score = 0;
    //self.result = [NSString stringWithFormat:@"Start flipping!"];
    self.cards = nil;
    for (int i=0; i<cardCount; i++)
    {
        SetCard *card = [deck drawRandomCard];
        self.cards[i]=card;
        
    }
    
    
}

@end
