//
//  Wrapper.h
//  FlatAero
//
//  Created by Mustafa Khalil on 3/1/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface Wrapper : NSObject
- (NSString *) printJSONFromBuffer: (uint8_t [_Nullable])buf from:(NSString *)table;
@end

NS_ASSUME_NONNULL_END
