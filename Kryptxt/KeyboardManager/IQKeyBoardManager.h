//
//  KeyBoardManager.h
//
// Copyright (c) 2013 Iftekhar Qurashi.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <Foundation/Foundation.h>

/*****************IQKeyBoardManager***********************/
@interface IQKeyBoardManager : NSObject
{
    //Boolean to maintain keyboard is showing or it is hide. To solve rootViewController.view.frame calculations;
    BOOL isKeyboardShowing;
    
    //To save rootViewController.view.frame.
    CGRect topViewBeginRect;
    
    //TextField or TextView object.
    UIView *textFieldView;
    
    //To save keyboard animation duration.
    CGFloat animationDuration;
  
    // To save keyboard size
    CGSize kbSize;
}

//Call it on your AppDelegate to initialize keyboardManager;
+(void)installKeyboardManager;

//To set keyboard distance from textField
+(void)setTextFieldDistanceFromKeyboard:(CGFloat)distance;  /*can't be less than zero. Default is 10.0*/

//Enable keyboard manager.
+(void)enableKeyboardManger;    /*default enabled*/

//Desable keyboard manager.
+(void)disableKeyboardManager;

//return YES if keyboard manager is enabled.
+(BOOL)isEnabled;

@end

