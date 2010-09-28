//
//  Created by Bill Dudney on 10/16/07.
//  Copyright 2007 Bill Dudney. All rights reserved.
//

#import "KeyFrameView.h"
#import <QuartzCore/QuartzCore.h>

// START:code.KeyFrameView..whole
@implementation KeyFrameView

- (id)initWithFrame:(NSRect)frame { // <label id="code.KeyFrameView.initWithFrame"/>
  self = [super initWithFrame:frame];
  if (self) {
    // inset by 3/8's
    CGFloat xInset = 3.0f * (NSWidth(frame) / 8.0f);
    CGFloat yInset = 3.0f * (NSHeight(frame) / 8.0f);
    NSRect moverFrame = NSInsetRect(frame, xInset, yInset);
    moverFrame.origin.x = NSMidX([self bounds]) - (NSWidth(moverFrame) / 2.0f);
    moverFrame.origin.y = NSMidY([self bounds]) - (NSHeight(moverFrame) / 2.0f);
    mover = [[NSImageView alloc] initWithFrame:moverFrame];
    [mover setImageScaling:NSScaleToFit];
    [mover setImage:[NSImage imageNamed:@"photo.jpg"]];
    [self addBounceAnimationTo:mover];
    [self addSubview:mover];
  }
  return self;
}

- (CAKeyframeAnimation *)originAnimation:(NSRect)frame {
  CAKeyframeAnimation *originAnimation = [CAKeyframeAnimation animation];
  CGMutablePathRef originPath = CGPathCreateMutable();
  CGPathMoveToPoint(originPath, NULL, NSMinX(frame), NSMinY(frame));
  CGPathAddLineToPoint(originPath, NULL, NSMinX(frame) - NSWidth(frame), NSMinY(frame) + NSHeight(frame) * 0.85);
  CGPathAddLineToPoint(originPath, NULL, NSMinX(frame), NSMinY(frame) - NSHeight(frame) * 1.75);
  CGPathAddLineToPoint(originPath, NULL, NSMinX(frame) + NSWidth(frame), NSMinY(frame) + NSHeight(frame) * 0.85);
  CGPathAddLineToPoint(originPath, NULL, NSMinX(frame), NSMinY(frame));
  CGPathCloseSubpath(originPath);
  originAnimation.path = originPath;
  originAnimation.duration = 2.0f;
  return originAnimation;
}

- (CAKeyframeAnimation *)sizeAnimation:(NSRect)frame {
  CAKeyframeAnimation *sizeAnimation = [CAKeyframeAnimation animation];
  CGMutablePathRef sizePath = CGPathCreateMutable();
  CGPathMoveToPoint(sizePath, NULL, NSWidth(frame), NSHeight(frame));
  CGPathAddLineToPoint(sizePath, NULL, NSWidth(frame) * 0.75, NSHeight(frame) * 0.75);
  CGPathAddLineToPoint(sizePath, NULL, NSWidth(frame) / 0.75, NSHeight(frame) / 0.75);
  CGPathAddLineToPoint(sizePath, NULL, NSWidth(frame) * 0.75, NSHeight(frame) * 0.75);
  CGPathAddLineToPoint(sizePath, NULL, NSWidth(frame) / 0.75, NSHeight(frame) / 0.75);
  CGPathAddLineToPoint(sizePath, NULL, NSWidth(frame), NSHeight(frame));
  CGPathCloseSubpath(sizePath);
  sizeAnimation.path = sizePath;
  sizeAnimation.duration = 2.0f;
  return sizeAnimation;
}

- (void)addBounceAnimationTo:(NSView *)view { // <label id="code.KeyFrameView.addBounceAnimationTo:"/>
  NSRect frame = [view frame];
  CAKeyframeAnimation *originAnimation = [self originAnimation:frame];
  CAKeyframeAnimation *sizeAnimation = [self sizeAnimation:frame];
  [view setAnimations:[NSDictionary dictionaryWithObjectsAndKeys:originAnimation, @"frameOrigin", sizeAnimation, @"frameSize", nil]];
}

- (BOOL)acceptsFirstResponder { // <label id="code.KeyFrameView.acceptsFirstResponder"/>
  return YES;
}

- (void)keyDown:(NSEvent *)event { // <label id="code.KeyFrameView.keyDown"/>
  if([[event characters] characterAtIndex:0] == 'b' || [[event characters] characterAtIndex:0] == 'B') {
    [self bounce];
  } else {
    [super keyDown:event];
  }
}

- (void)bounce { // <label id="code.KeyFrameView.bounce"/>
  NSRect rect = [mover frame];
  [[mover animator] setFrame:rect];
}

@end
// END:code.KeyFrameView.whole
