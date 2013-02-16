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
@end


@implementation SetCardMatchingGame

-(void)flipCardAtIndex:(NSUInteger)index
{
    SetCard *card  = [self cardAtIndex:index];
    // TODO: 3-card matching mode only - see CardMatchingGame flipCardAtIndex:
    
    card.faceUP = !card.faceUP;
    
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
