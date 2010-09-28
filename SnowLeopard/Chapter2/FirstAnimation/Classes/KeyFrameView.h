//
//  KeyFrameView.h
//  KeyFrameView
//
//  Created by Bill Dudney on 10/16/07.
//  Copyright 2007 Bill Dudney. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// END:code.KeyFrameView.interface
@interface KeyFrameView : NSView {
  NSImageView *mover;
}

- (void)bounce;
- (void)addBounceAnimationTo:(NSView *)view;

@end
// END:code.KeyFrameView.interface
