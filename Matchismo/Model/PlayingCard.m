//
//  PlayingCard.m
//  Matchismo
//
//  Created by lyonwj on 1/31/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;

-(int)match:(NSArray*) otherCards
{
    int score =0;
    
    if (otherCards.count == 1)      // for 2 card matching mode
    {
        PlayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit])
        {
            score =1;
        }
        
        else if (otherCard.rank == self.rank)
        {
            score = 4;
        }
    }
    
    else                            // for 3 card matching mode
    {
        PlayingCard *otherCard1 = otherCards[0];
        PlayingCard *otherCard2 = otherCards[1];
        
        if ([otherCard1.suit isEqualToString:otherCard2.suit] && [otherCard1.suit isEqualToString:self.suit] && [self.suit isEqualToString:otherCard2.suit])
        {
            score = 2;
        }
        
        else if (otherCard1.rank == self.rank == otherCard2.rank)
        {
            score = 6;
        }
    }
    return score;
}

-(NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

+(NSArray*) validSuits
{
    return @[@"♦", @"♥", @"♣", @"♠"];
}

+(NSArray*) rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+(NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank=rank;
    }
}
@end
