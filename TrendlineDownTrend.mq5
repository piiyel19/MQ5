#include <Trade\Trade.mqh>

CTrade Trade;
input int shift=0;

void OnTick()
{
   //datetime time  = iTime(Symbol(),Period(),shift);
   //double   open  = iOpen(Symbol(),Period(),shift);
   //double   high  = iHigh(Symbol(),Period(),shift);
   //double   low   = iLow(Symbol(),Period(),shift);
   //double   close = iClose(NULL,PERIOD_CURRENT,shift);
   //long     volume= iVolume(Symbol(),0,shift);
   //int      bars  = iBars(NULL,0);
   
   // first candle 
   int CandlesOnChart = ChartGetInteger(0,CHART_FIRST_VISIBLE_BAR,0);
   
   // variable lowest candle 
   int LowestCandle;
   
   //Variable for lower  candle price
   double LowCandle[];
   
   // sort array downward from the current chart
   ArraySetAsSeries(LowCandle,true);
   
   // fill array for 30 candle 
   CopyLow(_Symbol,_Period,0,CandlesOnChart,LowCandle);
   
   // Calculate lowest candle 
   LowestCandle =  ArrayMinimum(LowCandle,0,CandlesOnChart);
   
   // Create an Array for price 
   MqlRates PriceInformation[];
   
   // Sort to current to olders 
   ArraySetAsSeries(PriceInformation,true);
   
   // copy price data into array 
   int Data = CopyRates(_Symbol,_Period,0,CandlesOnChart, PriceInformation);
   
   // Delete Former Lines 
   ObjectDelete(_Symbol,"SimpleLowLineTrend");
   
   // Create 
   ObjectCreate( 
      _Symbol, // current symbol
      "SimpleLowLineTrend", // object name
      OBJ_TREND, // object type 
      0, // main window
      PriceInformation[LowestCandle].time, // for all candle 
      PriceInformation[LowestCandle].low, // from the lowest candle 
      PriceInformation[0].time, // draw to candle 0
      PriceInformation[0].low // draw candle low price
   ); 


   // set object color 
   ObjectSetInteger(0,"SimpleLowLineTrend",OBJPROP_COLOR,Yellow);
   
   // 
   ObjectSetInteger(0,"SimpleLowLineTrend",OBJPROP_STYLE,STYLE_DASH);
   
   ObjectSetInteger(0,"SimpleLowLineTrend",OBJPROP_WIDTH,1);
   
   ObjectSetInteger(0,"SimpleLowLineTrend",OBJPROP_RAY_RIGHT,true);
   
}
