//
//  CountryInformaton.h
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/12/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountryInformaton : NSObject

@property (nonatomic, copy, readonly) NSString *countryTitle;
@property (nonatomic, copy, readonly) NSString *cityTitle;

- (instancetype)initWithCountry:(NSString *)countryTitle city:(NSString *)cityTitle;

@end

NS_ASSUME_NONNULL_END
