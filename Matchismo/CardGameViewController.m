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

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation CardGameViewController

- (IBAction)newDeal:(UIButton *)sender // reset game state - DEAL button action
{
    [self.game resetGameStateWithCards:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    self.flipCount=0;
    [self updateUI];
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
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.resultsLabel.text = self.game.result;
}
- (IBAction)flipCard:(UIButton *)sender
{
   // PlayingCard* card = [self.flipDeck drawRandomCard];
   // [sender setTitle:card.contents forState:UIControlStateSelected];
   // sender.selected = !sender.selected;
   // self.flipCount++;
  //  NSLog(@"Selected card: %@", card.contents);

    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    
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
