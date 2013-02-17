//
//  Card.h
//  Matchismo
//
//  Created by lyonwj on 1/31/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString* contents;
@property (nonatomic, getter=isFaceUp) BOOL faceUP;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;
//@property (nonatomic, strong) NSMutableAttributedString* attribute;
-(int)match:(NSArray*) otherCards;

@end
