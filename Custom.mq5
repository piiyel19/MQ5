#include <Trade\Trade.mqh>
CTrade Trade;

input int shift=0;

void OnTick()
{
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits); 

   string entry_soca = "";
   double KArray[];
   double DArray[];
   
   
   int SochaDefinition = iStochastic(_Symbol,_Period,5,3,3,MODE_SMA,STO_CLOSECLOSE);
   
   CopyBuffer(SochaDefinition,0,0,3,KArray);
   CopyBuffer(SochaDefinition,1,0,3,DArray);
   
   double KValue0 = KArray[0];
   double DValue0 = DArray[0];
   
   double KValue1 = KArray[1];
   double DValue1 = DArray[1];
   
   
   if(KValue0>20 && DValue1>20 )
   {
      if((KValue0>DValue0) && (KValue1<DValue1))
      {
         entry_soca = "Buy";
      } 
   }
   
   
   if(KValue0<80 && DValue1<80 )
   {
      if((KValue0<DValue0) && (KValue1>DValue1))
      {
         entry_soca = "Sell";
      } 
   }
   
   
   
   
   
   
   
   // Macd
   string entry_macd = "";
   
   double myPriceArray_MACD[];
   
   // macd properties
   int MacDDefinition = iMACD(_Symbol,_Period,12,26,9,PRICE_CLOSE);
   
   ArraySetAsSeries(myPriceArray_MACD,true);
   
   // Define MA1 , one line , current candle 3 candle , store result
   CopyBuffer(MacDDefinition,0,0,1,myPriceArray_MACD);
   
   // get current macd
   float MacDValue = (myPriceArray_MACD[0]);
   
   if(MacDValue>0)
   {
      //Print("Trending Upwards ",MacDValue);
      entry_macd = "Buy";
   }
   
   
   if(MacDValue<0)
   {
      //Print("Trending Downward ",MacDValue);
      entry_macd = "Sell";
   }
   
   
   
   
   
   
   // EMA CROSSING
   string entry_ema_cross = "";
   double mv1[],mv2[];
   int movingAverageDefinition1 = iMA(_Symbol,_Period,8,0,MODE_EMA,PRICE_CLOSE);
   int movingAverageDefinition2 = iMA(_Symbol,_Period,14,0,MODE_EMA,PRICE_CLOSE);
   ArraySetAsSeries(mv1,true);
   ArraySetAsSeries(mv2,true);
   CopyBuffer(movingAverageDefinition1,0,0,3,mv1);
   CopyBuffer(movingAverageDefinition2,0,0,3,mv2);
   
   //EMA 8 > 14
   if((mv1[0]>mv2[0])&&(mv1[1]>mv2[1])){
      entry_ema_cross = "Buy";
      ObjectCreate(0,"Test",OBJ_LABEL,0,0,0,0,0,0,0);
      ObjectSetString(0,"Test",OBJPROP_TEXT,"Buy");
      ObjectSetInteger(0,"Test",OBJPROP_XDISTANCE,50);
      ObjectSetInteger(0,"Test",OBJPROP_YDISTANCE,50);
      ObjectSetInteger(0,"Test",OBJPROP_CORNER,CORNER_RIGHT_UPPER);
      ObjectSetInteger(0,"Test",OBJPROP_COLOR,clrAliceBlue);
   }
   
   
   // EMA 8 < 14
   if((mv1[0]<mv2[0])&&(mv1[1]<mv2[1])){
      entry_ema_cross = "Sell";
      ObjectCreate(0,"Test",OBJ_LABEL,0,0,0,0,0,0,0);
      ObjectSetString(0,"Test",OBJPROP_TEXT,"Sell");
      ObjectSetInteger(0,"Test",OBJPROP_XDISTANCE,50);
      ObjectSetInteger(0,"Test",OBJPROP_YDISTANCE,50);
      ObjectSetInteger(0,"Test",OBJPROP_CORNER,CORNER_RIGHT_UPPER);
      ObjectSetInteger(0,"Test",OBJPROP_COLOR,clrAliceBlue);
   }
   
   //Print(" Masuk : ",entry_ema);
   if(entry_ema_cross == "Sell" && PositionsTotal() < 1 )
   {
      // lot , symbol , price , sl , tp , 
      //Trade.Sell(0.10, NULL, Bid, (Bid+200 * _Point), (Bid-150 * _Point), NULL );
      entry_ema_cross = "Sell";
   }
   
   
   if(entry_ema_cross == "Buy" && PositionsTotal() < 1 )
   {
      // lot , symbol , price , sl , tp , 
      //Trade.Buy(0.10, NULL, Ask, (Ask-200 * _Point), (Ask+150 * _Point), NULL );
      entry_ema_cross = "Buy";
   }
   
   
   
   
   
   // create string signal 
     string entry_rsi="";
     
     // create array for price data
     double myRSIArray[];
     
     // define RSI Properties 
     int myRSIDefinition = iRSI(_Symbol,_Period,16,PRICE_CLOSE);
     
     // define current candle from 3 candles save in array 
     CopyBuffer(myRSIDefinition,0,0,3,myRSIArray);
     
     // current RSI Value 
     double myRSIValue = NormalizeDouble(myRSIArray[0],2);
     
     if(myRSIValue>50)
     {
         entry_rsi = "Buy"; 
     }
     
     
     if(myRSIValue<50)
     {
         entry_rsi = "Sell"; 
     }
     
     
     if(entry_rsi == "Sell" && PositionsTotal() < 1 )
     {
         entry_rsi = "Sell";
     }
     
     
     if(entry_rsi == "Buy" && PositionsTotal() < 1 )
     {
         entry_rsi = "Buy"; 
     }
   
   
   
   
   if((entry_soca == "Sell")&&(entry_macd == "Sell")&&(entry_ema_cross == "Sell")&&(entry_rsi == "Sell"))
   {
      Trade.Sell(0.10, NULL, Bid, (Bid+200 * _Point), (Bid-150 * _Point), NULL );
   }
  
  
   if((entry_soca == "Buy")&&(entry_macd == "Buy")&&(entry_ema_cross == "Buy")&&(entry_rsi == "Buy"))
   {
      Trade.Buy(0.10, NULL, Ask, (Ask-200 * _Point), (Ask+150 * _Point), NULL );
   }
   
   
   
   Print("Soca : ",entry_soca," | ","Macd : ",entry_macd," | ","Ema Cross : ",entry_ema_cross," | ","RSI : ",entry_rsi," | ");
}
