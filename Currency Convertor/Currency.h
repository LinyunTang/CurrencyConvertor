//
//  Currency.h
//  Currency Convertor
//
//  Created by Annabelle on 7/13/16.
//  Copyright © 2016 Annabelle Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject //<NSCoding>
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* alphaCode; //like USD, CAD, NSD
@property (strong, nonatomic) NSString* symbol; //like $, €, £
@property (strong, nonatomic) NSNumberFormatter* formatter;//to round
@property (strong, nonatomic) NSNumber* decimal;

//initializer needs to contain necessary properties of the class
-(Currency*) initWithName: (NSString*) aName
                alphaCode: (NSString*) aCode
                   symbol: (NSString*) aSymbol
            decimalPlaces: (NSNumber*) places;

-(NSString*) description; //print out whatever you need to debug.
-(NSString*) format: (NSNumber*) quantity; //formate the symbols into NSNumber
+(NSArray*) allCurrency;


@end
