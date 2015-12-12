//
//  ViewController.m
//  地区选择
//
//  Created by 刘凡 on 15/12/13.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "HMAddressPickerView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *textField2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    self.textField.inputView = [[HMAddressPickerView alloc] initWithCompletion:^(HMProvince *province, HMCity *city, HMDistrict *district) {
        weakSelf.textField.text = [NSString stringWithFormat:@"%@ - %@ - %@", province.name, city.name, district.name];
    }];
    
    self.textField2.inputView = [[HMAddressPickerView alloc] initWithCompletion:^(HMProvince *province, HMCity *city, HMDistrict *district) {
        weakSelf.textField2.text = [NSString stringWithFormat:@"%@(%@) - %@", city.name, city.zipcode, district.name];
    }];
    
    [self.textField becomeFirstResponder];
}

@end
