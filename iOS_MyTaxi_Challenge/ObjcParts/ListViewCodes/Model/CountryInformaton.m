//
//  CountryInformaton.m
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/12/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import "CountryInformaton.h"

@implementation CountryInformaton

- (instancetype)initWithCountry:(NSString *)countryTitle city:(NSString *)cityTitle {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _countryTitle = [countryTitle copy];
    _cityTitle = [cityTitle copy];
    
    return self;
}

@end
