//
//  HMAddress.h
//  地区选择
//
//  Created by 刘凡 on 15/12/13.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 地区模型
/// 地区
@interface HMDistrict: NSObject
/// 地区名
@property (nonatomic, copy) NSString *name;
@end

#pragma mark - 城市模型
/// 城市
@interface HMCity : NSObject
/// 城市名
@property (nonatomic, copy) NSString *name;
/// 邮政编码
@property (nonatomic, copy) NSString *zipcode;
/// 地区列表
@property (nonatomic, strong) NSArray *districts;

/// 返回索引对应的地区模型
- (HMDistrict *)districtWithIndex:(NSInteger)index;
@end

#pragma mark - 省模型
/// 省
@interface HMProvince : NSObject
/// 省名
@property (nonatomic, copy) NSString *name;
/// 城市列表
@property (nonatomic, strong) NSArray *cities;

/// 返回索引对应的城市模型
- (HMCity *)cityWithIndex:(NSInteger)index;

/// 从 plist 加载省份列表
+ (NSArray *)provinces;
@end
