//
//  Matchismo_Test_iOS.h
//  Matchismo_Test_iOS
//
//  Created by lyonwj on 2/15/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class SetCard;
@class SetCardDeck;
@class SetCardMatchingGame;


@interface Matchismo_Test_iOS : SenTestCase
{
    SetCard* setCard;
    SetCardDeck* deck;
    SetCardMatchingGame* game;
}

@end
