//
//  ViewController.m
//  Currency Convertor
//
//  Created by Annabelle on 7/13/16.
//  Copyright © 2016 Annabelle Tang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *foreignLabel;
@property (weak, nonatomic) IBOutlet UITextField *homeTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *homeScroll;
@property (weak, nonatomic) IBOutlet UIPickerView *foreignScroll;

- (IBAction)convertButton:(id)sender;

- (IBAction)switchButton:(id)sender;

- (IBAction)updateButton:(id)sender;

@end



@implementation ViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically
  self.homeScroll.dataSource = self;
  self.homeScroll.delegate = self;
  self.foreignScroll.delegate = self;
  self.foreignScroll.dataSource = self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
  return [Currency allCurrency].count;
}

-(NSString*) pickerView:(UIPickerView*)Scroll titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
  /* NSString* currencyName;
   switch(component)
   {
   case 0:
   currencyName =  @"American Dollars";
   case 1:
   currencyName = @"Chinese Yuan";
   case 2:
   currencyName = @"Japanese Yen";
   case 3:
   currencyName = @"Euro";
   case 4:
   currencyName = @"Canadian Dollar";
   }
   NSLog(@"The selected currency is: %@", currencyName);
   return currencyName;*/
  
  return  ((Currency*) [[Currency allCurrency] objectAtIndex:row]).name;
}



- (IBAction)convertButton:(id)sender {
  Currency* homeCurrency = [[Currency allCurrency] objectAtIndex:[self.homeScroll selectedRowInComponent:0]];
  Currency* foreignCurrency = [[Currency allCurrency] objectAtIndex:[self.foreignScroll selectedRowInComponent:0]];
  ExchangeRate* exchangeRate = [[ExchangeRate alloc] initWithHome: homeCurrency  Foreign:foreignCurrency];
  
  [exchangeRate fetch];
  NSString* result = [exchangeRate exchangeToForeign:@(self.homeTextField.text.floatValue)];
  self.foreignLabel.text = [foreignCurrency format: @(result.floatValue)];

  // self.foreignLabel.text = [exchangeRate exchangeToForeign:@(self.homeTextField.text.floatValue)];
  
  //[foreignCurrency format: [NSNumber numberFromString:result]];
  NSLog(@"Convert Button Pressed");
  
}



- (IBAction)updateButton:(id)sender {
  
  Currency* homeCurrency = [[Currency allCurrency] objectAtIndex:[self.homeScroll selectedRowInComponent:0]];
  Currency* foreignCurrency = [[Currency allCurrency] objectAtIndex:[self.foreignScroll selectedRowInComponent:0]];
  ExchangeRate* exchangeRate = [[ExchangeRate alloc] initWithHome: homeCurrency  Foreign:foreignCurrency];
  
  [exchangeRate update];
  self.foreignLabel.text = [exchangeRate exchangeToForeign:@(self.homeTextField.text.floatValue)];
  
}


- (IBAction)switchButton:(id)sender {
   Currency* homeCurrency = [[Currency allCurrency] objectAtIndex:[self.homeScroll selectedRowInComponent:0]];
  Currency* foreignCurrency = [[Currency allCurrency] objectAtIndex:[self.foreignScroll selectedRowInComponent:0]];
  ExchangeRate* exchangeRate = [[ExchangeRate alloc] initWithHome: homeCurrency  Foreign:foreignCurrency];
  
  self.homeTextField.text = self.foreignLabel.text;
  [exchangeRate reverse];
  self.foreignLabel.text = [exchangeRate exchangeToForeign:@(self.homeTextField.text.floatValue)];
  NSLog(@"switch button on!");
  
  NSInteger homeIndex =[self.homeScroll selectedRowInComponent:0];
  NSInteger foreignIndex =[self.foreignScroll selectedRowInComponent:0];
  [self.homeScroll selectRow:foreignIndex inComponent:0 animated:YES];
  [self.foreignScroll selectRow:homeIndex inComponent:0 animated:YES];
}



@end
