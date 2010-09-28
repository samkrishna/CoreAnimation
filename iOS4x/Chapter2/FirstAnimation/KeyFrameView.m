//
//  Created by Bill Dudney on 10/16/07.
//  Copyright 2007 Bill Dudney. All rights reserved.
//

#import "KeyFrameView.h"
#import <QuartzCore/QuartzCore.h>

// START:code.KeyFrameView..whole
@implementation KeyFrameView

- (id)initWithFrame:(CGRect)frame { // <label id="code.KeyFrameView.initWithFrame"/>
  self = [super initWithFrame:frame];
  if (self) {
    // inset by 3/8's
    CGFloat xInset = 3.0f * (frame.size.width / 8.0f);
    CGFloat yInset = 3.0f * (frame.size.height / 8.0f);
    CGRect moverFrame = CGRectInset(frame, xInset, yInset);
    moverFrame.origin.x = CGRectGetMidX([self bounds]) - (CGRectGetWidth(moverFrame) / 2.0f);
    moverFrame.origin.y = CGRectGetMidY([self bounds]) - (CGRectGetHeight(moverFrame) / 2.0f);
    mover = [[UIImageView alloc] initWithFrame:moverFrame];
//    [mover setImageScaling:NSScaleToFit];
    [mover setImage:[UIImage imageNamed:@"photo.jpg"]];
    [self addBounceAnimationTo:mover];
    [self addSubview:mover];
  }
  return self;
}

- (CAKeyframeAnimation *)originAnimation:(CGRect)frame {
  CAKeyframeAnimation *originAnimation = [CAKeyframeAnimation animation];
  CGMutablePathRef originPath = CGPathCreateMutable();
  CGPathMoveToPoint(originPath, NULL, CGRectGetMinX(frame), CGRectGetMinY(frame));
  CGPathAddLineToPoint(originPath, NULL, CGRectGetMinX(frame) - CGRectGetWidth(frame), CGRectGetMinY(frame) + CGRectGetHeight(frame) * 0.85);
  CGPathAddLineToPoint(originPath, NULL, CGRectGetMinX(frame), CGRectGetMinY(frame) - CGRectGetHeight(frame) * 1.75);
  CGPathAddLineToPoint(originPath, NULL, CGRectGetMinX(frame) + CGRectGetWidth(frame), CGRectGetMinY(frame) + CGRectGetHeight(frame) * 0.85);
  CGPathAddLineToPoint(originPath, NULL, CGRectGetMinX(frame), CGRectGetMinY(frame));
  CGPathCloseSubpath(originPath);
  originAnimation.path = originPath;
  originAnimation.duration = 2.0f;
  return originAnimation;
}

- (CAKeyframeAnimation *)sizeAnimation:(CGRect)frame {
  CAKeyframeAnimation *sizeAnimation = [CAKeyframeAnimation animation];
  CGMutablePathRef sizePath = CGPathCreateMutable();
  CGPathMoveToPoint(sizePath, NULL, CGRectGetWidth(frame), CGRectGetHeight(frame));
  CGPathAddLineToPoint(sizePath, NULL, CGRectGetWidth(frame) * 0.75, CGRectGetHeight(frame) * 0.75);
  CGPathAddLineToPoint(sizePath, NULL, CGRectGetWidth(frame) / 0.75, CGRectGetHeight(frame) / 0.75);
  CGPathAddLineToPoint(sizePath, NULL, CGRectGetWidth(frame) * 0.75, CGRectGetHeight(frame) * 0.75);
  CGPathAddLineToPoint(sizePath, NULL, CGRectGetWidth(frame) / 0.75, CGRectGetHeight(frame) / 0.75);
  CGPathAddLineToPoint(sizePath, NULL, CGRectGetWidth(frame), CGRectGetHeight(frame));
  CGPathCloseSubpath(sizePath);
  sizeAnimation.path = sizePath;
  sizeAnimation.duration = 2.0f;
  return sizeAnimation;
}

- (void)addBounceAnimationTo:(UIView *)view { // <label id="code.KeyFrameView.addBounceAnimationTo:"/>
  CGRect frame = [view frame];
  CAKeyframeAnimation *originAnimation = [self originAnimation:frame];
  [originAnimation setKeyPath:@"frameOrigin"];
  
  CAKeyframeAnimation *sizeAnimation = [self sizeAnimation:frame];
  [sizeAnimation setKeyPath:@"frameSize"];

	
  CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
  [animationGroup setAnimations:[NSArray arrayWithObjects:originAnimation, sizeAnimation, nil]];
	
  [[view layer] addAnimation:animationGroup	forKey:nil];
}

- (BOOL)acceptsFirstResponder { // <label id="code.KeyFrameView.acceptsFirstResponder"/>
  return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self bounce];
}

- (void)bounce { // <label id="code.KeyFrameView.bounce"/>
  CGRect rect = [mover frame];
	
  [UIView beginAnimations:@"bouncerAnimation" context:NULL];
	[mover setFrame:rect];
	[UIView	commitAnimations];
}

@end
// END:code.KeyFrameView.whole
