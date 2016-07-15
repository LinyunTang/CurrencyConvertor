//
//  ExchangeRate.m
//  Currency Convertor
//
//  Created by Annabelle on 7/13/16.
//  Copyright © 2016 Annabelle Tang. All rights reserved.
//

#import "ExchangeRate.h"

@implementation ExchangeRate
@synthesize home;
@synthesize foreign;
@synthesize rate;
@synthesize expiresOn;
@synthesize completionHandlerDictionary;
@synthesize ephemeralConfigObject;


-(ExchangeRate*) initWithHome:(Currency *)aHome Foreign:(Currency *)aForeign
{
 	self = [super init];
  if(self){
    self.home = aHome;
    self.foreign = aForeign;
    self.completionHandlerDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    self.ephemeralConfigObject = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    //self.fetch;
  }
  return self;
}


-(NSURL* )exchangeRateURL
{
  NSString* urlString = [NSString stringWithFormat: @"https://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20yahoo.finance.xchange%%20where%%20pair%%20in%%20(%%22%@%@%%22)&format=json&env=store%%3A%%2F%%2Fdatatables.org%%2Falltableswithkeys&callback=", self.home.alphaCode, self.foreign.alphaCode];
  return [NSURL URLWithString: urlString];
}


-(void) fetch
{
  NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
  NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: self.ephemeralConfigObject delegate: nil delegateQueue: mainQueue];
  NSLog(@"dispatching %@", [self description]);
  
  NSURLSessionTask* task = [delegateFreeSession dataTaskWithURL: [self exchangeRateURL]
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                // NSLog(@"Got response %@ with error %@.\n", response, error);
                                                id obj = [NSJSONSerialization JSONObjectWithData: data
                                                                                         options: 0
                                                                                           error: nil];
                                                if( [obj isKindOfClass: [NSDictionary class]] ){
                                                  NSDictionary *dict = (NSDictionary*)obj;
                                                  
                                                  NSDictionary* query = [dict objectForKey: @"query"];
                                                  NSDictionary* results = [query objectForKey:@"results"];
                                                  NSDictionary* rate1 = [results objectForKey:@"rate"];
                                                  NSString* updateRate = [rate1 objectForKey:@"Rate"];
                                                  self.rate = @(updateRate.floatValue);
                                                  NSLog(@"%@", [dict description]);
                                                  //NSLog(@"haha%@", self.rate);
                                                }else{
                                                  NSLog(@"Not a dictionary.");
                                                  exit(1);
                                                }}];
  
  [task resume];
  [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
}

-(bool) update{
  [self fetch];
  return YES;
}

-(void) reverse{
  //reverse the home and foreign currency objects
  Currency* a = self.home;
  self.home = self.foreign;
  self.foreign = a;
  
  //the new rate
  [self fetch];
}

-(NSString*) exchangeToForeign:(NSNumber *)value{
  //return  [self.home format: @(value.floatValue* self.rate.floatValue)];
  return  [NSString stringWithFormat: @"%f", (value.floatValue* self.rate.floatValue) ];
}



-(NSString*) name{
  return [NSString stringWithFormat:@ "%@ %@", self.home.alphaCode, self.foreign.alphaCode];
}

-(NSString*) description{
  return [NSString stringWithFormat:@  "homeName%@ foreignName%@", self.home, self.foreign];
}


@end
