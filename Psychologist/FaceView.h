//
//  FaceView.h
//  Happiness
//
//  Created by vaibhav patel on 10/18/12.
//  Copyright (c) 2012 vaibhav patel Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//29: Implement a protocol to assign a datasource to some controller for the smilness
@class FaceView;

@protocol FaceViewDataSource
- (float)smileForFaceView:(FaceView *)sender;
@end

//2: Creating a new custom view
@interface FaceView : UIView

//24: Define a propert scale
@property (nonatomic) CGFloat scale;

//27: make pinch public
-(void)pinch:(UIPinchGestureRecognizer *)gesture;
//30: Declare an property of the datasource
@property (nonatomic,weak) IBOutlet id <FaceViewDataSource> dataSource;

@end
