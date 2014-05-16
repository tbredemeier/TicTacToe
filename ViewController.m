//
//  ViewController.m
//  TicTacToe
//
//  Created by tbredemeier on 5/15/14.
//  Copyright (c) 2014 Mobile Makers Academy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *myLabelOne;
@property (strong, nonatomic) IBOutlet UILabel *myLabelTwo;
@property (strong, nonatomic) IBOutlet UILabel *myLabelThree;
@property (strong, nonatomic) IBOutlet UILabel *myLabelFour;
@property (strong, nonatomic) IBOutlet UILabel *myLabelFive;
@property (strong, nonatomic) IBOutlet UILabel *myLabelSix;
@property (strong, nonatomic) IBOutlet UILabel *myLabelSeven;
@property (strong, nonatomic) IBOutlet UILabel *myLabelEight;
@property (strong, nonatomic) IBOutlet UILabel *myLabelNine;
@property (strong, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UIButton *multiPlayerButton;
@property NSArray *subviews;
@property NSTimer *timer;
@property int seconds;
@property BOOL computerPlayer;
@property NSString *singlePlayerLabelText;
@property NSString *multiPlayerLabelText;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.subviews = self.view.subviews;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    self.singlePlayerLabelText = @"Single Player";
    self.multiPlayerLabelText = @"Multi-Player";
    [self.multiPlayerButton setTitle:self.singlePlayerLabelText forState:UIControlStateNormal];
    self.computerPlayer = YES;
    [self restartGame];
}

- (IBAction)onMultiPlayerButtonPressed:(UIButton *)button
{
    if([button.titleLabel.text isEqualToString:self.multiPlayerLabelText])
    {
        // play against the computer
        [self.multiPlayerButton setTitle:self.singlePlayerLabelText forState:UIControlStateNormal];
        self.computerPlayer = YES;
        if([self.whichPlayerLabel.text isEqualToString: @"O"])
            [self makePlay:[self pickRandomEmptyCell]];
    }
    else
    {
        // play against another human
        [self.multiPlayerButton setTitle:self.multiPlayerLabelText forState:UIControlStateNormal];
        self.computerPlayer = NO;
    }
}

- (void)restartGame
{
    for(int i = 0; i < 9; i++)
    {
        UILabel *test = self.subviews[i];
        test.text = @"";
    }

    [self nextTurn];
}

-(void)timerFired
{
    if(self.seconds >= 0)
        self.timerLabel.text = [NSString stringWithFormat:@"%d",self.seconds--];
    else
        [self nextTurn];
}

- (void)nextTurn
{
    if([self.whichPlayerLabel.text isEqualToString: @"X"])
    {
        self.whichPlayerLabel.text = @"O";
        self.whichPlayerLabel.textColor = [UIColor redColor];
        if([self computerPlayer])
            [self makePlay:[self pickRandomEmptyCell]];
    }
    else
    {
        self.whichPlayerLabel.text = @"X";
        self.whichPlayerLabel.textColor = [UIColor blueColor];
    }
    self.seconds = 10;
}

- (IBAction)onLabelTapped:(UITapGestureRecognizer *) tapGestureRecognizer
{
    CGPoint point;

    point = [tapGestureRecognizer locationInView:self.view];

    UILabel *selectedLabel = [self findLabelUsingPoint:point];
    if(selectedLabel && [selectedLabel.text isEqual: @""])
    {
        [self makePlay:selectedLabel];
    }
}

- (void)makePlay:(UILabel *)cell
{
    cell.text = self.whichPlayerLabel.text;
    cell.textColor = self.whichPlayerLabel.textColor;

    // check if there is a winner
    if(self.whoWon.length > 0)
    {
        self.whichPlayerLabel.text = @"";
        UIAlertView *winner = [[UIAlertView alloc] init];
        if(self.whoWon.length == 1)
            winner.title = [NSString stringWithFormat:@"%@ is the winner!",[self whoWon]];
        else
            winner.title = @"Cat's Game (draw)";
        [winner addButtonWithTitle:@"New Game"];
        [winner addButtonWithTitle:@"Quit"];
        winner.delegate = self;
        [winner show];
    }
    [self nextTurn];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
        [self restartGame];
    else
        exit(0);
}

- (UILabel *) findLabelUsingPoint:(CGPoint)point
{
    for(int i = 0; i < 9; i++)
    {
        UILabel *cell = self.subviews[i];
        if(CGRectContainsPoint(cell.frame, point))
            return cell;
    }
    return nil;
}

- (NSString *)whoWon
{
    // check top row
    if([self isWinningCombination:0 :1 :2])
        return [self.subviews[0] text];

    // check middle row
    if([self isWinningCombination:3 :4 :5])
        return [self.subviews[3] text];

    // check bottom row
    if([self isWinningCombination:6 :7 :8])
        return [self.subviews[6] text];

    // check first column
    if([self isWinningCombination:0 :3 :6])
        return [self.subviews[0] text];

    // check middle column
    if([self isWinningCombination:1 :4 :7])
        return [self.subviews[1] text];

    // check last column
    if([self isWinningCombination:2 :5 :8])
        return [self.subviews[2] text];

    // check first diagonal
    if([self isWinningCombination:0 :4 :8])
        return [self.subviews[0] text];

    // check second diagonal
    if([self isWinningCombination:2 :4 :6])
        return [self.subviews[2] text];

    // if any open cells, then game is not over
    for(int i = 0; i < 9; i++)
    {
        if([[self.subviews[i] text] length] == 0)
            return @"";
    }

    // no winner and no empty cells; must be a draw
    return @"draw";
}

- (BOOL)isWinningCombination:(int)a :(int)b :(int)c
{
    return([[self.subviews[a] text] length] > 0 &&
           [[self.subviews[a] text] isEqualToString:[self.subviews[b] text] ] &&
           [[self.subviews[a] text] isEqualToString:[self.subviews[c] text] ]);
}

- (UILabel *)pickRandomEmptyCell
{
    // pick the middle one, if available
    if([[self.subviews[4] text] length] == 0)
        return [self.subviews objectAtIndex:4];
    NSMutableArray *emptyCellList = [NSMutableArray array];
    for(int i = 0; i < 9; i++)
    {
        if([[self.subviews[i] text] length] == 0)
            [emptyCellList addObject:self.subviews[i]];
    }
    int index = arc4random_uniform([emptyCellList count]);
    return [emptyCellList objectAtIndex:index];
}

@end
