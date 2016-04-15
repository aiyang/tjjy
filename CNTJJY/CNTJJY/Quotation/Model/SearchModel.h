//
//  SearchModel.h
//
//  Created by iOS  on 16/4/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SearchModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double priceScale;
@property (nonatomic, strong) NSString *exchName;
@property (nonatomic, strong) NSString *symbolName;
@property (nonatomic, strong) NSString *tradeSession;
@property (nonatomic, strong) NSString *symbolCode;
@property (nonatomic, strong) NSString *codeType;
@property (nonatomic, strong) NSString *exchCode;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
