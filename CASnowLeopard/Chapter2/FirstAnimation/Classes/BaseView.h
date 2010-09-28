//
//  MoverView.h
//  MoveAView
//
//  Created by Bill Dudney on 10/16/07.
//  Copyright 2007 Bill Dudney. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// START:code.BaseView.interface
@interface BaseView : NSView {
  NSImageView *mover;
  BOOL isRight;
	NSRect leftFramePosition;
	NSRect rightFramePosition;
}

- (void)move;

@end
// END:code.BaseView.interface
