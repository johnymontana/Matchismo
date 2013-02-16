//
//  SetCard.h
//  Matchismo
//
//  Created by lyonwj on 2/13/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "Card.h"

@interface SetCard : NSObject



@property (strong, nonatomic) NSMutableAttributedString* attribute;

@property (strong, nonatomic) NSNumber* number; // count the number of things in attribute
@property (strong, nonatomic) NSString* symbol; // grab the first symbol from attribute
@property (strong, nonatomic) NSNumber* shading; // NSStrokeWidthAttributeName: + number=stroke only, - = fill and stroke
@property (strong, nonatomic) UIColor* color;

@property (nonatomic, getter=isFaceUp) BOOL faceUP;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;


+(NSArray*)validNumbers;
+(NSArray*)validSymbols;
+(NSArray*)validShadings;
+(NSArray*)validColors;
-(NSMutableAttributedString*)contents;

@end
