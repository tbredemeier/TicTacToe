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
@property NSTimer *timer;
@property int seconds;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    [self restartGame];
}

- (void)restartGame
{
    // reset the board
    self.myLabelOne.text   = @"";
    self.myLabelTwo.text   = @"";
    self.myLabelThree.text = @"";
    self.myLabelFour.text  = @"";
    self.myLabelFive.text  = @"";
    self.myLabelSix.text   = @"";
    self.myLabelSeven.text = @"";
    self.myLabelEight.text = @"";
    self.myLabelNine.text  = @"";

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
        selectedLabel.text = self.whichPlayerLabel.text;
        selectedLabel.textColor = self.whichPlayerLabel.textColor;

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
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self restartGame];
    }
    else
    {
        exit(0);
    }
}


- (UILabel *) findLabelUsingPoint:(CGPoint)point
{
    if(CGRectContainsPoint(self.myLabelOne.frame, point))
        return self.myLabelOne;
    if(CGRectContainsPoint(self.myLabelTwo.frame, point))
        return self.myLabelTwo;
    if(CGRectContainsPoint(self.myLabelThree.frame, point))
        return self.myLabelThree;
    if(CGRectContainsPoint(self.myLabelFour.frame, point))
        return self.myLabelFour;
    if(CGRectContainsPoint(self.myLabelFive.frame, point))
        return self.myLabelFive;
    if(CGRectContainsPoint(self.myLabelSix.frame, point))
        return self.myLabelSix;
    if(CGRectContainsPoint(self.myLabelSeven.frame, point))
        return self.myLabelSeven;
    if(CGRectContainsPoint(self.myLabelEight.frame, point))
        return self.myLabelEight;
    if(CGRectContainsPoint(self.myLabelNine.frame, point))
        return self.myLabelNine;
    return nil;
}

- (NSString *)whoWon
{
    NSString *labelValue;

    // get upper left corner value
    labelValue = self.myLabelOne.text;
    // test first column
    if([self.myLabelFour.text isEqualToString:labelValue] &&
       [self.myLabelSeven.text isEqualToString: labelValue])
        return labelValue;
    // test first row
    if([self.myLabelTwo.text isEqualToString:labelValue] &&
       [self.myLabelThree.text isEqualToString: labelValue])
        return labelValue;
    // test diagonal
    if([self.myLabelFive.text isEqualToString:labelValue] &&
       [self.myLabelNine.text isEqualToString:labelValue])
        return labelValue;

    // get middle left value
    labelValue = self.myLabelFour.text;
    // test middle row
    if([self.myLabelFive.text isEqualToString:labelValue] &&
       [self.myLabelSix.text isEqualToString: labelValue])
        return labelValue;

    // get middle top value
    labelValue = self.myLabelTwo.text;
    // test middle row
    if([self.myLabelFive.text isEqualToString:labelValue] &&
       [self.myLabelEight.text isEqualToString: labelValue])
        return labelValue;

    // get upper right value
    labelValue = self.myLabelThree.text;
    // test diagonal
    if([self.myLabelFive.text isEqualToString:labelValue] &&
       [self.myLabelSeven.text isEqualToString: labelValue])
        return labelValue;

    // get bottom right corner value
    labelValue = self.myLabelNine.text;
    // test last column
    if([self.myLabelThree.text isEqualToString:labelValue] &&
       [self.myLabelSix.text isEqualToString: labelValue])
        return labelValue;
    // test bottom row
    if([self.myLabelSeven.text isEqualToString:labelValue] &&
       [self.myLabelEight.text isEqualToString: labelValue])
        return labelValue;

    // test if draw (no solution)
    if(self.myLabelOne.text.length   > 0 &&
       self.myLabelTwo.text.length   > 0 &&
       self.myLabelThree.text.length > 0 &&
       self.myLabelFour.text.length  > 0 &&
       self.myLabelFive.text.length  > 0 &&
       self.myLabelSix.text.length   > 0 &&
       self.myLabelSeven.text.length > 0 &&
       self.myLabelEight.text.length > 0 &&
       self.myLabelNine.text.length  > 0)
        return @"draw";

    return @"";
}


@end
