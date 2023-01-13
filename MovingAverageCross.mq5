#include <Trade\Trade.mqh>

CTrade trade;

void OnTick()
{
   string entry="";
   
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);   
   double myMovingAverage20[],myMovingAverage50[];
   
   int movingAverageDefinition1 = iMA(_Symbol,_Period,20,0,MODE_EMA,PRICE_CLOSE);
   int movingAverageDefinition2 = iMA(_Symbol,_Period,50,0,MODE_EMA,PRICE_CLOSE);
   
   ArraySetAsSeries(myMovingAverage20,true);
   ArraySetAsSeries(myMovingAverage50,true);
   
   CopyBuffer(movingAverageDefinition1,0,0,3,myMovingAverage20);
   CopyBuffer(movingAverageDefinition2,0,0,3,myMovingAverage50);
   
   if(
      (myMovingAverage20[0]>myMovingAverage50[0])
      && 
      (myMovingAverage20[1]<myMovingAverage50[1])
   ){
      entry="Buy";
   }
   
   
   if(
      (myMovingAverage20[0]<myMovingAverage50[0])
      && 
      (myMovingAverage20[1]>myMovingAverage50[1])
   ){
      entry="Sell";
   }  
   
   
   if(entry=="Sell" && PositionsTotal()<1){
      trade.Sell(0.10,NULL,Bid,0,(Bid-150 * _Point),NULL);
      Print("Sell at ",Bid);
   }
   
   
   if(entry=="Buy" && PositionsTotal()<1){
      trade.Sell(0.10,NULL,Ask,0,(Bid+150 * _Point),NULL);
      Print("Buy at ",Ask);
   }
   
   Print(Ask);
}
