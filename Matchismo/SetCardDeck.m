//
//  SetCardDeck.m
//  Matchismo
//
//  Created by lyonwj on 2/15/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(id)init
{
    self = [super init];
    
    if(self)
    {
        for (NSString* symbol in [SetCard validSymbols])
        {
            SetCard *card = [[SetCard alloc] init];
            card.symbol = symbol;                       // symbol to have the correct # of symbols for setter
            [self addCard:card atTop:YES];
        }
    }
    
    return self;
}

@end
