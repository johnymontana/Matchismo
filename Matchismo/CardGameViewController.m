//
//  CardGameViewController.m
//  Matchismo
//
//  Created by lyonwj on 1/31/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck* flipDeck;
@end

@implementation CardGameViewController

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.flipCount++;
    
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
