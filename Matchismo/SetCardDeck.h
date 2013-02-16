//
//  SetCardDeck.h
//  Matchismo
//
//  Created by lyonwj on 2/15/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "Deck.h"
#import "SetCard.h"

@interface SetCardDeck : NSObject
-(void)addCard:(SetCard*)card atTop:(BOOL)atTop;
-(SetCard*)drawRandomCard;

@end
