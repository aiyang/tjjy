//
//  SearchModel.m
//
//  Created by iOS  on 16/4/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SearchModel.h"


NSString *const kSearchModelPriceScale = @"price_scale";
NSString *const kSearchModelExchName = @"exch_name";
NSString *const kSearchModelSymbolName = @"symbol_name";
NSString *const kSearchModelTradeSession = @"trade_session";
NSString *const kSearchModelSymbolCode = @"symbol_code";
NSString *const kSearchModelCodeType = @"code_type";
NSString *const kSearchModelExchCode = @"exch_code";


@interface SearchModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchModel

@synthesize priceScale = _priceScale;
@synthesize exchName = _exchName;
@synthesize symbolName = _symbolName;
@synthesize tradeSession = _tradeSession;
@synthesize symbolCode = _symbolCode;
@synthesize codeType = _codeType;
@synthesize exchCode = _exchCode;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.priceScale = [[self objectOrNilForKey:kSearchModelPriceScale fromDictionary:dict] doubleValue];
            self.exchName = [self objectOrNilForKey:kSearchModelExchName fromDictionary:dict];
            self.symbolName = [self objectOrNilForKey:kSearchModelSymbolName fromDictionary:dict];
            self.tradeSession = [self objectOrNilForKey:kSearchModelTradeSession fromDictionary:dict];
            self.symbolCode = [self objectOrNilForKey:kSearchModelSymbolCode fromDictionary:dict];
            self.codeType = [self objectOrNilForKey:kSearchModelCodeType fromDictionary:dict];
            self.exchCode = [self objectOrNilForKey:kSearchModelExchCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.priceScale] forKey:kSearchModelPriceScale];
    [mutableDict setValue:self.exchName forKey:kSearchModelExchName];
    [mutableDict setValue:self.symbolName forKey:kSearchModelSymbolName];
    [mutableDict setValue:self.tradeSession forKey:kSearchModelTradeSession];
    [mutableDict setValue:self.symbolCode forKey:kSearchModelSymbolCode];
    [mutableDict setValue:self.codeType forKey:kSearchModelCodeType];
    [mutableDict setValue:self.exchCode forKey:kSearchModelExchCode];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.priceScale = [aDecoder decodeDoubleForKey:kSearchModelPriceScale];
    self.exchName = [aDecoder decodeObjectForKey:kSearchModelExchName];
    self.symbolName = [aDecoder decodeObjectForKey:kSearchModelSymbolName];
    self.tradeSession = [aDecoder decodeObjectForKey:kSearchModelTradeSession];
    self.symbolCode = [aDecoder decodeObjectForKey:kSearchModelSymbolCode];
    self.codeType = [aDecoder decodeObjectForKey:kSearchModelCodeType];
    self.exchCode = [aDecoder decodeObjectForKey:kSearchModelExchCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_priceScale forKey:kSearchModelPriceScale];
    [aCoder encodeObject:_exchName forKey:kSearchModelExchName];
    [aCoder encodeObject:_symbolName forKey:kSearchModelSymbolName];
    [aCoder encodeObject:_tradeSession forKey:kSearchModelTradeSession];
    [aCoder encodeObject:_symbolCode forKey:kSearchModelSymbolCode];
    [aCoder encodeObject:_codeType forKey:kSearchModelCodeType];
    [aCoder encodeObject:_exchCode forKey:kSearchModelExchCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    SearchModel *copy = [[SearchModel alloc] init];
    
    if (copy) {

        copy.priceScale = self.priceScale;
        copy.exchName = [self.exchName copyWithZone:zone];
        copy.symbolName = [self.symbolName copyWithZone:zone];
        copy.tradeSession = [self.tradeSession copyWithZone:zone];
        copy.symbolCode = [self.symbolCode copyWithZone:zone];
        copy.codeType = [self.codeType copyWithZone:zone];
        copy.exchCode = [self.exchCode copyWithZone:zone];
    }
    
    return copy;
}


@end
