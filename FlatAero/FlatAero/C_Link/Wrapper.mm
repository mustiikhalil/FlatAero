//
//  Wrapper.m
//  FlatAero
//
//  Created by Mustafa Khalil on 3/1/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

#import "Wrapper.h"
#import "flat/flat.h"

@implementation Wrapper
- (NSString *) printJSONFromBuffer:(uint8_t [])buf from:(NSString *)table {
    std::string _table = std::string([table UTF8String]);
    flat::FLAT flat(_table);
    return [NSString stringWithCString: flat.parse(buf).c_str()
                              encoding: [NSString defaultCStringEncoding]];
}
@end
