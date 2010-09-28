//
//  KeyFrameView.h
//  KeyFrameView
//
//  Created by Bill Dudney on 10/16/07.
//  Copyright 2007 Bill Dudney. All rights reserved.
//

#import <UIKit/UIKit.h>

// END:code.KeyFrameView.interface
@interface KeyFrameView : UIView {
  UIImageView *mover;
}

- (void)bounce;
- (void)addBounceAnimationTo:(UIView *)view;

@end
// END:code.KeyFrameView.interface
