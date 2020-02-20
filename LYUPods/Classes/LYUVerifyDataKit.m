//
//  LYUVerifyDataKit.m
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import "LYUVerifyDataKit.h"

BOOL LYUStringNil(id obj) {
    if (!obj) return YES;
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)obj;
        
        if (string.length == 0
            || [string compare:@"null" options:NSCaseInsensitiveSearch] == NSOrderedSame
            || [string compare:@"<null>" options:NSCaseInsensitiveSearch] == NSOrderedSame
            || [string compare:@"nil" options:NSCaseInsensitiveSearch] == NSOrderedSame
            || [string compare:@"<nil>" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            return YES;
        }
        return NO;
    }
    return YES;
}

BOOL LYUAttributedStringNil(id obj) {
    if (!obj) return YES;
    if ([obj isKindOfClass:[NSAttributedString class]]) {
        NSString *string = [(NSAttributedString *)obj string];
        if (string.length == 0
            || [string compare:@"null" options:NSCaseInsensitiveSearch] == NSOrderedSame
            || [string compare:@"<null>" options:NSCaseInsensitiveSearch] == NSOrderedSame
            || [string compare:@"nil" options:NSCaseInsensitiveSearch] == NSOrderedSame
            || [string compare:@"<nil>" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            return YES;
        }
        return NO;
    }
    return YES;
}


NSString *LYUDefultString(id string, NSString *def) {
    if (LYUStringNil(string)) {
        if (LYUStringNil(def)) {
            return @"";
        }
        return def;
    }
    return string;
}


BOOL LYUSetNil(id obj) {
    if (!obj) return YES;
    
    if ([obj isKindOfClass:[NSSet class]]) {
        NSSet *set = (NSSet *)obj;
        return set.allObjects.count == 0;
    }
    return YES;
}

BOOL LYUDictionaryNil(id obj) {
    if (!obj) return YES;
    
    // dictionary
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *)obj;
        return dictionary.allKeys.count == 0;
    }
    return YES;
}

BOOL LYUArrayNil(id obj) {
    if (!obj) return YES;
    
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)obj;
        return array.count == 0;
    }
    return YES;
}

BOOL LYUNil(id obj) {
    if (!obj) return YES;
    
    // string
    if ([obj isKindOfClass:[NSString class]]) {
        return LYUStringNil(obj);
    }
    
    // dictionary
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return LYUDictionaryNil(obj);
    }
    
    // array
    if ([obj isKindOfClass:[NSArray class]]) {
        return LYUArrayNil(obj);
    }
    
    // set
    if ([obj isKindOfClass:[NSSet class]]) {
        return LYUSetNil(obj);
    }
    
    return NO;
}
