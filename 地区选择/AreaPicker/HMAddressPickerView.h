//
//  HMAddressPickerView.h
//  地区选择
//
//  Created by 刘凡 on 15/12/13.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMAddress.h"

@interface HMAddressPickerView : UIPickerView

- (instancetype)initWithCompletion:(void (^)(HMProvince *province, HMCity *city, HMDistrict *district))completion;

@end
