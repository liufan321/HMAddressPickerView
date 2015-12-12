//
//  HMAddressPickerView.m
//  地区选择
//
//  Created by 刘凡 on 15/12/13.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMAddressPickerView.h"

@interface HMAddressPickerView() <UIPickerViewDataSource, UIPickerViewDelegate>
/// 省份数据数组
@property (nonatomic, strong) NSArray *provinces;
/// 完成回调
@property (nonatomic, copy) void (^completionCallBack)(HMProvince *, HMCity *, HMDistrict *);
@end

@implementation HMAddressPickerView

#pragma mark - 构造函数
- (instancetype)initWithCompletion:(void (^)(HMProvince *province, HMCity *city, HMDistrict *district))completion {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        
        self.delegate = self;
        self.dataSource = self;
        
        self.completionCallBack = completion;
        
        // 默认选中第一条数据
        [self selectRow:0 inComponent:0 animated:NO];
        [self.delegate pickerView:self didSelectRow:0 inComponent:0];
    }
    return self;
}

#pragma mark - UIPickerViewDataSource
/// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

/// 每列对应行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    switch (component) {
        case 0:
            return self.provinces.count;
            break;
        case 1: {
            NSInteger pRow = [pickerView selectedRowInComponent:0];
            
            HMProvince *province = self.provinces[pRow];
            
            return province.cities.count;
        }
            break;
        case 2: {
            NSInteger pRow = [pickerView selectedRowInComponent:0];
            NSInteger cRow = [pickerView selectedRowInComponent:1];
            
            HMProvince *province = self.provinces[pRow];
            HMCity *city = [province cityWithIndex:cRow];
            
            return city.districts.count;
        }
            break;
            
        default:
            return 0;
            break;
    }
}

#pragma mark - UIPickerViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    NSString *text;
    switch (component) {
        case 0:
            text = [self.provinces[row] name];
            break;
        case 1: {
            NSInteger pRow = [pickerView selectedRowInComponent:0];
            
            HMProvince *province = self.provinces[pRow];
            HMCity *city = [province cityWithIndex:row];
            
            text = city.name;
        }
            break;
        case 2: {
            NSInteger pRow = [pickerView selectedRowInComponent:0];
            NSInteger cRow = [pickerView selectedRowInComponent:1];
            
            HMProvince *province = self.provinces[pRow];
            HMCity *city = [province cityWithIndex:cRow];
            HMDistrict *district = [city districtWithIndex:row];
            
            text = district.name;
        }
            break;
        default:
            return nil;
            break;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.text = text;
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component < 2) {
        [pickerView reloadAllComponents];
    }
    
    // 获得当前选中结果
    NSInteger pRow = [pickerView selectedRowInComponent:0];
    NSInteger cRow = [pickerView selectedRowInComponent:1];
    NSInteger dRow = [pickerView selectedRowInComponent:2];
    
    HMProvince *province = self.provinces[pRow];
    HMCity *city = [province cityWithIndex:cRow];
    HMDistrict *district = [city districtWithIndex:dRow];
    
    if (self.completionCallBack != nil && province != nil && city != nil && district != nil) {
        self.completionCallBack(province, city, district);
    }
}

#pragma mark - 懒加载数据
- (NSArray *)provinces {
    if (_provinces == nil) {
        _provinces = [HMProvince provinces];
    }
    return _provinces;
}

@end
