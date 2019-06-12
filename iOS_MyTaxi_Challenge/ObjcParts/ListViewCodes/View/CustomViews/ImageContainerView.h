//
//  ImageContainerView.h
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/11/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageContainerView : UIView

@property (strong, nonatomic) UIImageView *headerImageView;
@property (strong, nonatomic) UIVisualEffectView *blurEffectView;
@property (strong, nonatomic) UILabel *screenTitle;

- (void) blurViewActivationManager:(BOOL *)value;
- (void) screenTitleActivationManager:(BOOL *)value;

@end

NS_ASSUME_NONNULL_END
