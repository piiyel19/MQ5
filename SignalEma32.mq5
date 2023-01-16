#include <Trade\Trade.mqh>

CTrade trade;
input int shift=0;

void OnTick()
{
   string entry="";
   
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits); 
   
   
   datetime time  = iTime(Symbol(),Period(),shift);
   double   open  = iOpen(Symbol(),Period(),shift);
   double   high  = iHigh(Symbol(),Period(),shift);
   double   low   = iLow(Symbol(),Period(),shift);
   double   close = iClose(NULL,PERIOD_CURRENT,shift);
   long     volume= iVolume(Symbol(),0,shift);
   int      bars  = iBars(NULL,0);
     
   double ema32_high[],ema32_low[],ema32_close[];
   
   int movingAverageDefinition1 = iMA(_Symbol,_Period,32,0,MODE_EMA,PRICE_HIGH);
   int movingAverageDefinition2 = iMA(_Symbol,_Period,32,0,MODE_EMA,PRICE_LOW);
   int movingAverageDefinition3 = iMA(_Symbol,_Period,32,0,MODE_EMA,PRICE_CLOSE);
   
   ArraySetAsSeries(ema32_high,true);
   ArraySetAsSeries(ema32_low,true);
   ArraySetAsSeries(ema32_close,true);
   
   CopyBuffer(movingAverageDefinition1,0,0,3,ema32_high);
   CopyBuffer(movingAverageDefinition2,0,0,3,ema32_low);
   CopyBuffer(movingAverageDefinition3,0,0,3,ema32_close);
   
   
   if((close < ema32_close[0]) && (close < ema32_close[1])) {
      Print("Sell");
   }
   
   if((high > ema32_high[0]) && (high > ema32_high[1])) {
      Print("Buy");
   }
     
   
   //Print(close);
}
