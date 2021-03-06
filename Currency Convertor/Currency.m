//
//  Currency.m
//  Currency Convertor
//
//  Created by Annabelle on 7/13/16.
//  Copyright © 2016 Annabelle Tang. All rights reserved.
//

#import "Currency.h"

@implementation Currency
@synthesize name;
@synthesize alphaCode;
@synthesize symbol;
@synthesize formatter;
@synthesize decimal;




-(Currency*) initWithName: (NSString*) aName
                alphaCode: (NSString*) aCode
                   symbol: (NSString*) aSymbol
            decimalPlaces: (NSNumber*) places{
 	self = [super init];
  if(self){
    self.name = aName;
    self.alphaCode = aCode;
    self.symbol = aSymbol;
   self.decimal  = places;
    
    
    self.formatter = [[NSNumberFormatter alloc] init];
    self.formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    self.formatter.currencySymbol = aSymbol;
    self.formatter.maximumFractionDigits = places.unsignedIntegerValue;
    self.formatter.roundingMode = kCFNumberFormatterRoundHalfUp;
  }
  return self;
}

//print out whatever you need to debug.
-(NSString*) description{
  
  return [NSString stringWithFormat:@ "name%@ alphaCode%@ symbol%@", self.name, self.alphaCode, self.symbol];
}

//maximumFractionDigits
//roundingIncrement


//formate the symbols into NSNumber
-(NSString*) format: (NSNumber*) quantity{
/* quantity = self.decimal;
 self.formatter = [[NSNumberFormatter alloc] init];
 self.formatter.numberStyle = NSNumberFormatterCurrencyStyle;
 return [formatter stringFromNumber:quantity];*/
  //[formatter release];
  //return [NSString stringWithFormat:@"%@ %@ ", self.formatter, self.symbol];
  //return [NSString stringWithFormat:@"%@", quantity];
  //NSLog(@"%@", [self.formatter stringFromNumber:n]);

 return [self.formatter stringFromNumber:quantity];

}

+(NSArray*) allCurrency
{
  NSMutableArray* allCurrency = [[NSMutableArray alloc] init];
  [allCurrency addObject: [[Currency alloc] initWithName:@"US Dollar" alphaCode:@"USD" symbol:@"$" decimalPlaces: @2 ]];
  [allCurrency addObject: [[Currency alloc] initWithName:@"Chinese Yuan" alphaCode:@"CNY" symbol:@"¥" decimalPlaces: @2 ]];
  [allCurrency addObject: [[Currency alloc] initWithName:@"Japanese Yen" alphaCode:@"JPY" symbol:@"¥" decimalPlaces: @0 ]];
  [allCurrency addObject: [[Currency alloc] initWithName:@"Euro" alphaCode:@"EUR" symbol:@"€" decimalPlaces: @2 ]];
  [allCurrency addObject: [[Currency alloc] initWithName:@"Canadian Dollar" alphaCode:@"CAD" symbol:@"$" decimalPlaces: @2 ]];

  return (NSArray*)allCurrency;
}

@end