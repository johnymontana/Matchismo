//
//  CardGameViewController.m
//  Matchismo
//
//  Created by lyonwj on 1/31/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UISwitch *gameModeSwitch;      // toggle to set 3-card / 2-card match mode
@property (strong, nonatomic) NSMutableArray* resultTextArray;      // holds all result text for rewind func
@property (weak, nonatomic) IBOutlet UISlider *rewindSlider;        // rewind to display previous result text

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;    // these are the cards
@property (strong, nonatomic) CardMatchingGame *game;               // Model with game playing logic
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController

-(GameResult*)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

-(void)viewDidLoad
{
   // [self updateUI];
   // self.rewindSlider.maximumValue=0;
    [self newDeal:nil];
    
}

- (IBAction)adjustRewindSlider:(UISlider *)sender   // handle value changed event for UISlider rewindSlider
{
    // TODO: adjust resultsLabel with appropriate NSString from resultTextArray
    NSLog(@"Slider adjusted to: %f", self.rewindSlider.value);
    self.resultsLabel.text = [self.resultTextArray objectAtIndex:(NSUInteger)sender.value];
    NSLog(@"Grabbing result text at index: %i", (int)sender.value);
}

- (IBAction)newDeal:(UIButton *)sender // reset game state - DEAL button action
{
    [self.game resetGameStateWithCards:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    self.flipCount=0;
    [self updateUI];
    self.gameModeSwitch.enabled = YES; // enable game mode switch
    self.game.three_card_match_mode = NO;
    self.gameModeSwitch.on = NO;
    self.rewindSlider.maximumValue=0;
    self.rewindSlider.value=0;
    self.resultTextArray = [[NSMutableArray alloc] init];
    self.gameResult = nil;
    
}

//-(NSMutableArray *)resultTextArray
//{
//    if (!_resultTextArray) _resultTextArray = [[NSMutableArray alloc] init];
//    return _resultTextArray;
//}


- (IBAction)setMatchMode:(UISwitch *)sender
{

    [self.game setThree_card_match_mode:sender.on];
}

-(CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    
    return _game;
}



-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
}

-(void)updateUI
{
    UIImage* cardBackImage = [UIImage imageNamed:@"GearSurfer.png"];
    UIImage* cardFrontImage = [UIImage imageNamed:@"texture.png"];
    
    for (UIButton *cardButton in self.cardButtons)  // set images and title for all card buttons
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setBackgroundImage:cardFrontImage forState:UIControlStateSelected];
        [cardButton setBackgroundImage:cardFrontImage forState:UIControlStateDisabled|UIControlStateSelected];
        [cardButton setBackgroundImage:cardBackImage forState:UIControlStateNormal];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;    // should the card be face up?
        cardButton.enabled = !card.isUnplayable;    // has the card already been matched?
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;   // set transparant if card has already been matched
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    [self.resultTextArray addObject:self.game.result];
    self.resultsLabel.text = self.game.result;  // show result text
    // TODO:    append self.game.result to self.resultTextArray
    //          adjust maximumValue on rewindSlider (++)
    //          move slider to maximumValue
    self.rewindSlider.maximumValue = self.resultTextArray.count-1;
    self.rewindSlider.value = self.rewindSlider.maximumValue;
}
- (IBAction)flipCard:(UIButton *)sender // handles a button touch event
{
    //[self updateUI];
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    self.gameResult.score = self.game.score;
    
    self.gameModeSwitch.enabled = NO;       // disable gameModeSwitch is game play has started
    
    // TODO: draw random card from deck and set sender title to card description
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
    
    // TODO: update flipsLabel to show number of remaining cards in flipDeck
}

@end
