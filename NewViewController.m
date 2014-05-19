//
//  NewViewController.m
//  TicTacToe
//
//  Created by tbredemeier on 5/19/14.
//  Copyright (c) 2014 Mobile Makers Academy. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// DRY helper method
//- (void)goToURLString:(NSString *)urlString
//{
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.myWebView  loadRequest:request];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self goToURLString:@"http://www.mobilemakers.co"];
    //    [self textField.text = @"http://www.mobilemakers.co"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
