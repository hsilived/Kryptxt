//
//  SlideUpCancelButton.h
//  SlideUpMenu
//
//  Created by DeviL on 2013-10-02.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideUpCancelButton : UIButton {
    
@private
    NSMutableDictionary *backgroundStates;
    
@public
    
}

- (void)setBackgroundColor:(UIColor *)_backgroundColor forState:(UIControlState)_state;

@end