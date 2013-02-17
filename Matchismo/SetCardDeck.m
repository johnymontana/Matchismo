//
//  SetCardDeck.m
//  Matchismo
//
//  Created by lyonwj on 2/15/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"
@interface SetCardDeck()
@property (strong, nonatomic) NSMutableArray* cards;
@end

@implementation SetCardDeck

-(id)init
{
    self = [super init];
    
    if(self)
    {
 //       NSString* testSymbol = [SetCard validSymbols][0];
   
 //       for (int i=0; i<25; i++)
 //       {
 //           SetCard *card = [[SetCard alloc] init];
 //           card.symbol = testSymbol;
 //           [self addCard:card atTop:YES];
 //           NSLog(@"Card in deck: %@", self.cards[i]);
 //       }
        for (NSString* symbol in [SetCard validSymbols])
        {
            for (UIColor* color in [SetCard validColors])
            {
                for (NSNumber* number in [SetCard validNumbers])
                {
                    for (NSNumber* shade in [SetCard validShadings])
                    {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;            // symbol to have the correct # of symbols for setter
                        card.number = number;
                        card.color = color;
                        
                        card.shading = shade;  // Shading not going to work this way
                        
                        //NSLog(@"set symbol to %@", card.symbol);
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

-(NSMutableArray*) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];    // lazy instantiation
    return _cards;
}

-(void)addCard:(SetCard *)card atTop:(BOOL)atTop
{
    if (atTop)
    {
        [self.cards insertObject:card atIndex:0];
    }
    else
    {
        [self.cards addObject:card];
    }
    
}

-(SetCard*)drawRandomCard
{
    SetCard *randomCard = nil;
    
    if (self.cards.count)
    {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
