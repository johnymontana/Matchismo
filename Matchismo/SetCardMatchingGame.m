//
//  SetCardMatchingGame.m
//  Matchismo
//
//  Created by lyonwj on 2/15/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "SetCardMatchingGame.h"
@interface SetCardMatchingGame()
@property (strong, nonatomic) NSMutableArray* cards;
@end


@implementation SetCardMatchingGame

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card  = [self cardAtIndex:index];
    // TODO: 3-card matching mode only - see CardMatchingGame flipCardAtIndex:
    card.faceUP = !card.faceUP;
    
}

-(NSMutableArray*) cards
{
    if (!_cards) _cards =[[NSMutableArray alloc] init];
    return _cards;
    
}
@end
