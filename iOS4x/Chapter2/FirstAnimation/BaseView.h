//
//  MoverView.h
//  MoveAView
//
//  Created by Bill Dudney on 10/16/07.
//  Copyright 2007 Bill Dudney. All rights reserved.
//

#import <UIKit/UIKit.h>

// START:code.BaseView.interface
@interface BaseView : UIView {
  UIImageView *mover;
  BOOL isRight;
	CGRect leftFramePosition;
	CGRect rightFramePosition;
}

- (void)move;

@end
// END:code.BaseView.interface
