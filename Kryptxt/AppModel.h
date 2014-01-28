//
//  AppModel.h
//  Kryptxt
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AppModel : NSObject <UIPopoverControllerDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate> {
    
    UIViewController *parent;
    BOOL fullVersion;
    NSArray *_products;
    NSNumberFormatter * _priceFormatter;
}

@property (nonatomic) BOOL firstTime;
@property (strong, nonatomic) UIColor *borderColor;
@property (nonatomic) BOOL reachable;

+ (AppModel *)sharedManager;

#pragma mark - String Methods

- (NSString *)cleanText:(NSString *)text;
- (NSString *)unConvertText:(NSString *)text;
- (NSString *)stripTextOfSpaces:(NSString *)text;
- (NSUInteger)countOccurrencesOfString:(NSString *)search FromString:(NSString *)str;

#pragma mark - View rotaters

- (CGSize)currentSize;
- (void)centerTextInTextView:(UITextView *)tv;
- (void)adjustTextForObject:(UITextView *)tv;
- (void)adjustInfoTextForObject:(UITextView *)tv;

#pragma mark - Message Methods

- (void)sendSMSer:(NSArray *)toRecipient messageBody:(NSString *)messageBody inView:(UIViewController *)vc;
- (void)sendEmailWithMessageBody:(NSString *)messageBody inView:(UIViewController *)vc;
- (void)sendEmailWithMessageBody:(NSString *)messageBody andSubject:(NSString *)subject inView:(UIViewController *)vc;
- (void)sendEmailWithMessageBody:(NSString *)messageBody andRecipient:(NSArray *)recipient andSubject:(NSString *)subject inView:(UIViewController *)vc;
- (UIImage *)createPostPicWithText:(NSString *)definition andFacebook:(BOOL)facebook;
- (void)sendLikeFacebookInView:(UIViewController *)vc;
- (void)sendFacebookWithMessage:(NSString *)message andImage:(UIImage *)image andURL:(NSString *)url inView:(UIViewController *)vc;
- (void)sendLikeTweetInView:(UIViewController *)vc;
- (void)sendTweetWithMessage:(NSString *)message andImage:(UIImage *)image andURL:(NSString *)url inView:(UIViewController *)vc;

+ (BOOL)isTwitterAvailable;
+ (BOOL)isSocialAvailable;

#pragma mark - Image Methods

- (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size;

#pragma mark - in app purchases

- (BOOL)validatePurchase;
- (void)loadProducts;

@end
