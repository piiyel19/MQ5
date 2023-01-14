#include<Trade\Trade.mqh>

CTrade Trade;

void OnTick()
  {
     // Calculate Ask Price 
     double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
     
     
     // Calculate Bid Price 
     double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
     
     // create string signal 
     string signal="";
     
     // create array for price data
     double myRSIArray[];
     
     // define RSI Properties 
     int myRSIDefinition = iRSI(_Symbol,_Period,14,PRICE_CLOSE);
     
     // define current candle from 3 candles save in array 
     CopyBuffer(myRSIDefinition,0,0,3,myRSIArray);
     
     // current RSI Value 
     double myRSIValue = NormalizeDouble(myRSIArray[0],2);
     
     if(myRSIValue>70)
     {
         signal = "Sell"; 
     }
     
     
     if(myRSIValue>30)
     {
         signal = "Buy"; 
     }
     
     
     if(signal == "Sell" && PositionsTotal() < 1 )
     {
         // lot , symbol , price , sl , tp , 
         Trade.Sell(0.10, NULL, Bid, (Bid+200 * _Point), (Bid-150 * _Point), NULL );
     }
     
     
     if(signal == "Buy" && PositionsTotal() < 1 )
     {
         // lot , symbol , price , sl , tp , 
         Trade.Buy(0.10, NULL, Ask, (Ask-200 * _Point), (Ask+150 * _Point), NULL );
     }
     
     Comment("The signal is now ", signal);
     
     
     
     
  }
