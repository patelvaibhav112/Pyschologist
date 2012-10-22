//
//  FaceView.m
//  Happiness
//
//  Created by vaibhav patel on 10/18/12.
//  Copyright (c) 2012 vaibhav patel Inc. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView
//5: Drag a generic view on the story board, and connect IBOutlet of controller to it. Also change its identity inspector property to the class name.

//25: Synthesize scale and implment getters and setters.
#define DEFAULT_SCALE 0.90
@synthesize scale = _scale;
@synthesize dataSource = _dataSource;

-(CGFloat)scale
{
    if(!_scale)
        return DEFAULT_SCALE;
    else
        return _scale;
}

- (void)setScale:(CGFloat)scale
{
    if(scale!=_scale)
    {
        _scale = scale;
        [self setNeedsDisplay];
    }
}

//26: Implement pinch handler
-(void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded))
    {
        self.scale *= gesture.scale;
        gesture.scale = 1;
    }
}
//Automatically generated
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //25: add setup
        [self setup];
    }
    return self;
}

// 26: override awake from nib to add setup
- (void)awakeFromNib
{
    [self setup];
}
//24: implment setup to content mode redraw in both init with frame and awakefromnib
- (void)setup
{
    self.contentMode = UIViewContentModeRedraw;
}

//7: Implement a method that draws circles
- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContenxt:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}
//6: Overridden from UIView

- (void)drawRect:(CGRect)rect
{
    //1: Get context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //8: Find midpoint of the view.
    CGPoint midpoint;
    midpoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midpoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    //9: How big our face will be? Find shortest width of the view. Our face will be 90% of the shortest width of the view.
    
    CGFloat size = self.bounds.size.width/2;
    if(self.bounds.size.height < self.bounds.size.width)
        size = self.bounds.size.height/2;
    
    //10:Our circle will be 90% of the shortest side of the screen
    size = size*self.scale;
    
    //11:Set line width and color
    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];
    
    //12: draw the face
    [self drawCircleAtPoint:midpoint withRadius:size inContenxt:context];
    
    //13: draw the eyes
    CGPoint eyepoint;
    
    //14: move left from the center of the circle
    eyepoint.x = midpoint.x - size * 0.35;
    
    //15: move up from the center of the circle
    eyepoint.y = midpoint.y - size * 0.35;
    
    //16: Draw left eye
    [self drawCircleAtPoint:eyepoint withRadius:size*0.10 inContenxt:context];
    
    //17: move eyepoint to the right by 2 times the distance from center.
    eyepoint.x = eyepoint.x + size*2*0.35;
    
    //17: Draw right eye
    [self drawCircleAtPoint:eyepoint withRadius:size*0.10 inContenxt:context];
    
    //18draw mouth
#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_SMILE 0.25
    
    //19: find the mouth starting point
    CGPoint mouthStart;
    mouthStart.x = midpoint.x - MOUTH_H*size;
    mouthStart.y = midpoint.y + MOUTH_V*size;
    
    //20: find the mouth ending point
    CGPoint mouthEnd = mouthStart;
    mouthEnd.x = mouthEnd.x + size*2*MOUTH_H;
    
    //21: find the mouth control points
    CGPoint mouthCP1 = mouthStart;
    mouthCP1.x = mouthCP1.x + MOUTH_H*size*2/3;
    
    CGPoint mouthCP2 =  mouthEnd;
    mouthCP2.x = mouthEnd.x - MOUTH_H * size * 2/3;
    
    //31: use data source to get the smiliness
    float smile = [self.dataSource smileForFaceView:self];
    
    if(smile < -1.0) smile = -1;
    else if(smile > 1.0) smile = 1;
    
    CGFloat smileOffset = MOUTH_SMILE * size*smile;
    mouthCP1.y = mouthCP1.y + smileOffset;
    mouthCP2.y = mouthCP2.y + smileOffset;
    
    //22: draw mouth
    CGContextBeginPath(context);
    CGContextMoveToPoint(context,mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP1.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y);
    CGContextStrokePath(context);
}


@end
