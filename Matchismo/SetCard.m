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
    return @[@"▲", @"●", @"■"];
}

+(NSArray*) validShadings
{
    // TODO: return array of valid shadings
    // TODO: how to get three shadings?
    //return @[ @-3, @0, @3];
    //return @[[NSNumber numberWithInt:NSUnderlineStyleNone], [NSNumber numberWithInt:NSUnderlineStyleSingle ]];
    return @[@0, @1, @3];
}

+(NSArray*) validColors
{
    // TODO: return array of valid colors
    return @[[UIColor greenColor], [UIColor redColor], [UIColor blackColor]];
}

-(void)setSymbol:(NSString *)symbol
{
    _symbol=symbol;
    self.attribute = [[NSMutableAttributedString alloc] initWithString:symbol];
   // NSLog(@"setting card symbol to: %@", symbol);
   // NSLog(@"self.attribute is now %@", self.attribute);
    
    // don't need to set any attributes here
    //[self.attribute addAttribute:<#(NSString *)#> value:<#(id)#> range:<#(NSRange)#>
}

-(void)setColor:(UIColor *)color
{
    _color = color;
    [self.attribute addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [self.attribute length])];
    
    
}
-(void)setNumber:(NSNumber *)number
{
    _number = number;
    
    if ([number isEqualToNumber:@1])
    {
        // do nothing
    }
    
    else if ([number isEqualToNumber:@2])
    {
        self.attribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", self.symbol, self.symbol]];
    }
    
    else if ([number isEqualToNumber:@3])
    {
        self.attribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@", self.symbol, self.symbol, self.symbol]];
    }
}

-(void)setShading:(NSNumber *)shading
{
    _shading = shading;
    //[self.attribute addAttribute:NSStrokeWidthAttributeName value:shading range:NSMakeRange(0, [self.attribute length])];
    
    [self.attribute addAttribute:NSUnderlineStyleAttributeName value:shading range:NSMakeRange(0, [self.attribute length])];
}
// TODO: setters and getters
// setters: update attriubte.attributes
// getters: just return the property ivar?

-(NSMutableAttributedString*)contents
{
//    if (!_attribute) _attribute = [[NSMutableAttributedString alloc] init];
//    return _attribute;
    return self.attribute;
}

-(int)match:(NSArray *)otherCards
{
    // TODO: otherCards MUST have 2 elements - error check results for this?
    
   // int score = 0;
    
    NSMutableSet* symbolSet = [[NSMutableSet alloc] init];
    NSMutableSet* colorSet = [[NSMutableSet alloc] init];
    NSMutableSet* shadeSet = [[NSMutableSet alloc] init];
    NSMutableSet* numberSet = [[NSMutableSet alloc] init];
    
    SetCard* otherCard1 = otherCards[0];
    SetCard* otherCard2 = otherCards[1];
    NSRange length;
    
    NSDictionary* cardAttributeDict = [self.attribute attributesAtIndex:0 effectiveRange:&length];
    NSDictionary* otherCard1AttributeDict = [otherCard1.attribute attributesAtIndex:0 effectiveRange:&length];
    NSDictionary* otherCard2AttributeDict = [otherCard2.attribute attributesAtIndex:0 effectiveRange:&length];
    
    NSArray* dictArray = @[cardAttributeDict, otherCard1AttributeDict, otherCard2AttributeDict];
    
    for (SetCard* myCard in @[self, otherCard1, otherCard2])
    {
        [symbolSet addObject:myCard.symbol];
        [numberSet addObject:myCard.number];
    }
    
    for (NSDictionary* dict in dictArray)
    {
        [colorSet addObject:dict[NSForegroundColorAttributeName]];
        [shadeSet addObject:dict[NSUnderlineStyleAttributeName]];
        
    }
    
    
    
    // TODO: matching logic here:
    
    // if 3 different attributes....
    
    // if 3 same attributes
    
    if ([symbolSet count]==2)
        return 0;
    if ([colorSet count]==2)
        return 0;
    if ([shadeSet count]==2)
        return 0;
    if ([numberSet count]==2)
        return 0;
    
    return 1;
}


@end
