//
//  SetCard.m
//  Matchismo
//
//  Created by lyonwj on 2/13/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+(NSArray*) validNumbers
{
    // TODO: return array of valid ranges(?)
    return @[@1, @2, @3];
}

+(NSArray*) validSymbols
{
    // TODO: return array of valid symbols
    return @[@"▲", @"⬤", @"◼"];
}

+(NSArray*) validShadings
{
    // TODO: return array of valid shadings
    // TODO: how to get three shadings?
    return @[ @-5, @0, @5];
    
}

+(NSArray*) validColors
{
    // TODO: return array of valid colors
    return @[[UIColor greenColor], [UIColor orangeColor], [UIColor yellowColor]];
}

-(void)setSymbol:(NSString *)symbol
{
    _symbol=symbol;
    _attribute = [[NSMutableAttributedString alloc] initWithString:symbol];
    
    // don't need to set any attributes here
    //[self.attribute addAttribute:<#(NSString *)#> value:<#(id)#> range:<#(NSRange)#>
}
// TODO: setters and getters
// setters: update attriubte.attributes
// getters: just return the property ivar?

-(NSMutableAttributedString*)contents
{
    return self.attribute;
}

-(int)match:(NSArray *)otherCards
{
    // TODO: otherCards MUST have 2 elements - error check results for this?
    
    int score = 0;
    
    SetCard* otherCard1 = otherCards[0];
    SetCard* otherCard2 = otherCards[1];
    
    // TODO: matching logic here:
    
    // if 3 different attributes....
    
    // if 3 same attributes
}


@end
