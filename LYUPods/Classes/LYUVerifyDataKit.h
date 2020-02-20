//
//  LYUVerifyDataKit.h
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//  数据校验等方法

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT BOOL LYUStringNil(id obj);
FOUNDATION_EXPORT BOOL LYUAttributedStringNil(id obj);
FOUNDATION_EXPORT BOOL LYUDictionaryNil(id obj);
FOUNDATION_EXPORT BOOL LYUArrayNil(id obj);
FOUNDATION_EXPORT BOOL LYUSetNil(id obj);
FOUNDATION_EXPORT BOOL LYUNil(id obj);
FOUNDATION_EXPORT NSString *LYUDefultString(id string, NSString *def);
