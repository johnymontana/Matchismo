//
//  Matchismo_Test_iOS.m
//  Matchismo_Test_iOS
//
//  Created by lyonwj on 2/15/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "Matchismo_Test_iOS.h"
#import "SetCardMatchingGame.h"
#import "SetCard.h"
#import "SetCardDeck.h"
@implementation Matchismo_Test_iOS

// TODO: test alloc init a SetCard, SetCardDeck and SetCardMatching game
// TODO: draw random cards from a deck to populate SetCardMatchingGame.cards
// TODO: getters / setters for SetCard

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

-(void)testSetCard
{
    setCard = [[SetCard alloc] init];
    
    STAssertNotNil(setCard, @"Test setCard is not null");
}

-(void)testSetCardDeck
{
    deck = [[SetCardDeck alloc] init];
    
    STAssertNotNil(deck, @"Test deck is not null");
}

-(void)testSetCardMatchingGame
{
    game = [[SetCardMatchingGame alloc] initWithCardCount:24 usingDeck:[[SetCardDeck alloc] init]];
    STAssertNotNil(game, @"Test deck is not null");
}
@end
