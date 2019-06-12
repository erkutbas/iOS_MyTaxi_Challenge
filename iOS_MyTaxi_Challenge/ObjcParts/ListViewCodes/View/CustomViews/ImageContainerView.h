//
//  ImageContainerView.h
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/11/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryInformaton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageContainerView : UIView

@property (strong, nonatomic) UIImageView *headerImageView;
@property (strong, nonatomic) UIVisualEffectView *blurEffectView;
@property (strong, nonatomic) UILabel *mainScreenTitle;
@property (strong, nonatomic) UILabel *detailScreenTitle;

- (void) blurViewActivationManager:(BOOL *)value;
- (void) screenTitleActivationManager:(BOOL *)value;
- (void) setHeaderImageView:(UIImageView * _Nonnull)headerImageView;
- (void)setTitlePrompts:(CountryInformaton *)data;

@end

NS_ASSUME_NONNULL_END
