//
//  GameResultsViewController.m
//  Matchismo
//
//  Created by lyonwj on 2/14/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResult.h"

@interface GameResultsViewController ()

@end

@implementation GameResultsViewController

-(void)updateUI
{
    NSString* displayText = @"";
    for (GameResult* result in [GameResult allGameResults])
         {
             displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %gs)\n", result.score, result.end, round(result.duration)];
             
         }
    self.display.text = displayText;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}
-(void)setup
{
    // no setup to do
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}


@end
