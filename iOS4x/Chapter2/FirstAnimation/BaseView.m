//
//  Created by Bill Dudney on 10/16/07.
//  Copyright 2007 Bill Dudney. All rights reserved.
//

#import "BaseView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BaseView

//START:code.BaseView.frames
-(void)initializeFramePositions {
	CGFloat  frameX = CGRectGetWidth([self frame]);
	CGFloat  frameY = CGRectGetHeight([self frame]);
	
	leftFramePosition = NSMakeRect(0.0f, 0.0f, frameX / 4.0f, 
                                 frameY / 4.0f);
	rightFramePosition = NSMakeRect(7.0f * frameX / 8.0f, 
                                  7.0f *frameY / 16.0f, 
                                  frameX / 8.0f, frameY/ 8.0f); 
	
	mover = [[UIImageView alloc] initWithFrame:leftFramePosition];
	isRight = NO;
}

-(void)addImageToSubview
{
//	[mover setImageScaling:NSScaleToFit];
	[mover setImage:[UIImage imageNamed:@"photo.jpg"]];
}
//END:code.BaseView.frames

//START:code.BaseView.setup
- (id)initWithFrame:(CGRect)frame { // <label id="code.BaseView.initWithFrame"/>
  self = [super initWithFrame:frame];
  if (self) {
		[self initializeFramePositions]; // <label id="code.BaseView.initWithFrame.1"/>
		[self addImageToSubview];        // <label id="code.BaseView.initWithFrame.2"/>
		[self addSubview:mover];         // <label id="code.BaseView.initWithFrame.3"/>
	}
  return self;
}
//END:code.BaseView.setup

//START:code.BaseView.keys
- (BOOL)acceptsFirstResponder { // <label id="code.BaseView.acceptsFirstResponder"/>
  return YES;
}

- (void)keyDown:(UIEvent *)event { // <label id="code.BaseView.keyDown"/>
	[self move];
}
//END:code.BaseView.keys

//START:code.BaseView.move
- (void)move { // <label id="code.BaseView.move"/>
  if(isRight) {
    [[mover animator] setFrame:leftFramePosition];
  } else {
    [[mover animator] setFrame:rightFramePosition];
  }
	isRight = !isRight;
}
//END:code.BaseView.move

@end
