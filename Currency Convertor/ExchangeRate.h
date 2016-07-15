//
//  ExchangeRate.h
//  Currency Convertor
//
//  Created by Annabelle on 7/13/16.
//  Copyright © 2016 Annabelle Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@interface ExchangeRate : NSObject //<NSCoding>

@property (strong, nonatomic) Currency* home;
@property (strong, nonatomic) Currency*  foreign;
@property (strong, nonatomic) NSNumber* rate;
@property (strong, nonatomic) NSDate* expiresOn;
@property (strong) NSMutableDictionary *completionHandlerDictionary;
@property (strong) NSURLSessionConfiguration *ephemeralConfigObject;
//+(NSArray*) allExchangeRates;

//self.rate = [self updateRate] → we don’t need to return anything but we do need to know whether it has successfully update
-(NSString*) exchangeToForeign: (NSNumber*) value; //one is divide
-(void) reverse; //reverse the units and the text, also, the exchange rate, still calls exchangeToForeign though
-(NSString*) name; //create the name of the exchangeRateObject, such as USDCAD or CADUSD for debug use
-(NSString*) description;
-(bool) update;

-(NSURL*) exchangeRateURL;

-(void) fetch;

-(ExchangeRate*) initWithHome: (Currency*) aHome
                     Foreign: (Currency*) aForeign;


@end
