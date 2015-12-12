# HMAddressPickerView

地区选择视图 - 自定义 PickerVier 练习

使用步骤：

1. 导入头文件

```objc
#import "HMAddressPickerView.h"
```

2. 设置输入视图和完成回调

```objc
__weak typeof(self) weakSelf = self;
self.textField.inputView = [[HMAddressPickerView alloc] initWithCompletion:^(HMProvince *province, HMCity *city, HMDistrict *district) {
    weakSelf.textField.text = [NSString stringWithFormat:@"%@ - %@ - %@", province.name, city.name, district.name];
}];
```

代码比较简单，没有放在 `cocoapod` 上了，有兴趣的朋友直接那去用就好，:D
