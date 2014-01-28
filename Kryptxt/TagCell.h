//
//  TagCell.h
//  Kryptxt
//
//  Created by DeviL on 2013-01-25.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *profileLabel;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UILabel *profileID;
@property (strong, nonatomic) IBOutlet UIImageView *profileSelected;

@end
