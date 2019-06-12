//
//  ListDataViewModel.h
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/12/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VehicleListViewData.h"
#import <UIKit/UIKit.h>
#import "CountryInformaton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListDataViewModel : NSObject

@property (nonatomic, copy, readonly) NSMutableArray<VehicleInformation *> *vehicleArray;
@property (nonatomic, copy, readonly) UIImage *topImage;
@property (nonatomic, copy, readonly) CountryInformaton *countryInformation;

- (instancetype)initWithArrayData:(NSMutableArray<VehicleInformation *> *)arrayData topImage:(UIImage *)inputImage countryInformation:(CountryInformaton *)countryInfo;


- (NSString *) activationTitle:(NSUInteger)index;
- (NSString *) idValue:(NSUInteger)index;
- (NSUInteger*) numberOfVehicle;
- (VehicleInformation *) returnVehicleInformationData:(NSUInteger)index;
- (UIImage *) returnTopImage;
- (CountryInformaton *) returnCountryInformation;

@end

NS_ASSUME_NONNULL_END
