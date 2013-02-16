//
//  SetGameViewController.m
//  Matchismo
//
//  Created by lyonwj on 2/13/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCard.h"
#import "GameResult.h"
#import "SetCardDeck.h"
#import "SetCardMatchingGame.h"


@interface SetGameViewController ()

@property (nonatomic) int flipCount;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) SetCardMatchingGame* game;
@property (strong, nonatomic) GameResult* gameResult;

@end

@implementation SetGameViewController

-(void)viewDidLoad
{
    //[super viewDidLoad];
    [self newDeal:nil];
}


-(SetCardMatchingGame*)game
{
    if (!_game) _game = [[SetCardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc] init]];
    return _game;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
}

-(void)updateUI
{
    // set buttons title
    
    for (UIButton *cardButton in self.cardButtons)
    {
        
        SetCard* card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
       // NSLog(@"Card is class: %@", [[card class] description]);
        NSLog(@"Index of cardButton: %d", [self.cardButtons indexOfObject:cardButton]);
       // NSLog(@"Card.contents is class: %@", [[card.contents class] description]);
        NSLog(@"Card.contents: %@", card.attribute);
        
        //cardButton.
        
        [cardButton setAttributedTitle:card.attribute forState:UIControlStateNormal];
        [cardButton setAttributedTitle:card.attribute forState:UIControlStateSelected];
     //   [cardButton setTitle:card.contents forState:UIControlStateNormal];
     //   [cardButton setTitle:card.contents forState:UIControlStateSelected];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)newDeal:(UIButton *)sender
{
    // reset game state
    [self.game resetGameStateWithCards:self.cardButtons.count usingDeck:[[SetCardDeck alloc] init]];
    [self updateUI];
}



@end
