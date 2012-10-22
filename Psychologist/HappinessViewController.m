//
//  HappinessViewController.m
//  Happiness
//
//  Created by vaibhav patel on 10/18/12.
//  Copyright (c) 2012 vaibhav patel Inc. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"
@interface HappinessViewController () <FaceViewDataSource>

//3: Creating an outlet to the custom view
@property (nonatomic, weak) IBOutlet FaceView *faceview;
@end

@implementation HappinessViewController
@synthesize happiness = _happiness;
@synthesize faceview = _faceview;

//4: Whenever our model gets set, we want to redraw the view.
- (void)setHappiness:(int)happiness
{
    _happiness = happiness;
    [self.faceview setNeedsDisplay];
}

//28: Add pinch recognizer to the faceview
-(void) setFaceview:(FaceView *)faceview
{
    _faceview = faceview;
    [self.faceview addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceview action:@selector(pinch:)]];
    //34: Add a pan gesture recognizer. This gesture is added and controlled by this controller itself.
    [self.faceview addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
    //33: set this controller as the faceview's datasource.
    self.faceview.dataSource = self;
}

//35: Implemnt the pan gesture recognizer.
- (void) pan:(UIPanGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged) ||
       gesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint translation = [gesture translationInView:self.faceview];
        self.happiness -= translation.y/2;
        [gesture setTranslation:CGPointZero inView:self.faceview];
        
    }
}
//23: implement auto rotate
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

//32: Implement simle for faceview
- (float)smileForFaceView:(FaceView *)sender
{
    return (self.happiness - 50)/50.0;
}

@end
