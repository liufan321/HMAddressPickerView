//
//  HMAddress.m
//  地区选择
//
//  Created by 刘凡 on 15/12/13.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMAddress.h"

#pragma mark - 地区模型
@implementation HMDistrict

+ (instancetype)districtWithName:(NSString *)name {
    id obj = [[self alloc] init];
    
    [obj setValue:name forKey:@"name"];
    
    return obj;
}

+ (NSArray *)districtsWithArray:(NSArray *)array {
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSString *name in array) {
        [arrayM addObject:[HMDistrict districtWithName:name]];
    }
    
    return arrayM.copy;
}

- (NSString *)description {
    return [self dictionaryWithValuesForKeys:@[@"name"]].description;
}

@end

#pragma mark - 城市模型
@implementation HMCity

- (HMDistrict *)districtWithIndex:(NSInteger)index {
    if (index >= 0 && index < self.districts.count) {
        return self.districts[index];
    }
    return nil;
}

+ (instancetype)cityWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValue:dict[@"name"] forKey:@"name"];
    [obj setValue:dict[@"zipcode"] forKey:@"zipcode"];
    [obj setValue:[HMDistrict districtsWithArray:dict[@"sub"]] forKey:@"districts"];
    
    return obj;
}

+ (NSArray *)citiesWithArray:(NSArray *)array {

    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dict in array) {
        [arrayM addObject:[HMCity cityWithDict:dict]];
    }

    return arrayM.copy;
}

- (NSString *)description {
    return [self dictionaryWithValuesForKeys:@[@"name", @"zipcode", @"districts"]].description;
}

@end

#pragma mark - 省模型
@implementation HMProvince

- (HMCity *)cityWithIndex:(NSInteger)index {
    if (index >= 0 && index < self.cities.count) {
        return self.cities[index];
    }
    return nil;
}

+ (instancetype)provinceWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValue:dict[@"name"] forKey:@"name"];
    [obj setValue:[HMCity citiesWithArray:dict[@"sub"]] forKey:@"cities"];
    
    return obj;
}

+ (NSArray *)provinces {
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"address" withExtension:@"plist"]];
    NSArray *list = dict[@"Provinces"];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:list.count];
    
    for (NSDictionary *dict in list) {
        [arrayM addObject:[HMProvince provinceWithDict:dict]];
    }
    
    return arrayM.copy;
}

- (NSString *)description {
    return [self dictionaryWithValuesForKeys:@[@"name", @"cities"]].description;
}

@end
