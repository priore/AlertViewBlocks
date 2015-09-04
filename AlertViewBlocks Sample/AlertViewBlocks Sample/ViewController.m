//
//  ViewController.m
//  AlertViewBlocks Sample
//
//  Created by Danilo Priore on 04/09/15.
//  Copyright (c) 2015 Danilo Priore. All rights reserved.
//

#import "ViewController.h"
#import "AlertViewBlocks.h"

@implementation ViewController

- (IBAction)didAlertViewSelected:(id)sender
{
    [AlertViewBlocks confirmWithTitle:@"Title" message:@"your message here" confirm:^{
        
        NSLog(@"Ok button selected!");
        
    } cancel:^{
        
        NSLog(@"Cancel button selected!");

    }];
}

- (IBAction)didAlertViewYesNoSelected:(id)sender
{
    [AlertViewBlocks confirmWithTitle:@"Title" message:@"your message ere" YesNo:YES confirm:^{

        NSLog(@"Yes button selected!");

    } cancel:^{
        
        NSLog(@"No button selected!");

    }];
}

- (IBAction)didAlertViewMultiSelected:(id)sender
{
    [AlertViewBlocks alertWithTitle:@"Title" message:@"you message here" confirm:^(NSInteger index) {

        NSLog(@"Button #%i selected!", index);
    
    } cancel:^{

        NSLog(@"Cancel button selected!");
    
    } otherButtonTitles:@"Button 1", @"Button 2", @"Button 3", nil];
}

@end
