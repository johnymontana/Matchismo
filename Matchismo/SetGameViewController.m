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

-(GameResult*) gameResult
{
    if (!_gameResult) _gameResult=[[GameResult alloc] init];
    return _gameResult;
}

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

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    self.gameResult.score = self.game.score;

}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}
-(void)updateUI
{
    // set buttons title
    UIImage* cardFrontImage = [UIImage imageNamed:@"texture.png"];
    for (UIButton *cardButton in self.cardButtons)
    {
        
        SetCard* card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
       // NSLog(@"Card is class: %@", [[card class] description]);
        NSLog(@"Index of cardButton: %d", [self.cardButtons indexOfObject:cardButton]);
       // NSLog(@"Card.contents is class: %@", [[card.contents class] description]);
        NSLog(@"Card.contents: %@", card.attribute);
        
        [cardButton setBackgroundImage:cardFrontImage forState:UIControlStateSelected];
        [cardButton setBackgroundImage:cardFrontImage forState:UIControlStateDisabled|UIControlStateSelected];
        
        [cardButton setAttributedTitle:card.attribute forState:UIControlStateNormal];
        [cardButton setAttributedTitle:card.attribute forState:UIControlStateSelected];
     //   [cardButton setTitle:card.contents forState:UIControlStateNormal];
     //   [cardButton setTitle:card.contents forState:UIControlStateSelected];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
       // [self.resultTextArray addObject:self.game.result];
        self.resultsLabel.text = self.game.result;  // show result text
        cardButton.selected = card.faceUP;
        cardButton.enabled = !card.isUnplayable;    // has the card already been matched?
        cardButton.alpha = card.isUnplayable ? 0.1 : 1.0;   // set transparant if card has already been matched


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
    self.flipCount=0;

    self.gameResult = nil;
    [self updateUI];
}



@end
