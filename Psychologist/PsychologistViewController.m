//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by vaibhav patel on 10/22/12.
//  Copyright (c) 2012 vaibhav patel Inc. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"
@interface PsychologistViewController ()
@property (nonatomic) int diagnosis;

@end

@implementation PsychologistViewController
@synthesize diagnosis = _diagnosis;

- (void)setAndShowDiagnosis:(int)diagnosis
{
    self.diagnosis = diagnosis;
    [self performSegueWithIdentifier:@"ShowDiagnosis" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowDiagnosis"]){
        [segue.destinationViewController setHappiness:self.diagnosis];
    }
}
- (IBAction)flying
{
    [self setAndShowDiagnosis:85];
}


- (IBAction)apple
{
    [self setAndShowDiagnosis:100];
}

- (IBAction)dragons
{
    [self setAndShowDiagnosis:20];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
