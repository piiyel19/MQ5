void OnTick()
  {
//---
   static double LastHigh;
   static double LastClose;
   
   MqlRates PriceInfo[];
   
   ArraySetAsSeries(PriceInfo,true);
   
   int PriceData = CopyRates(_Symbol,_Period,0,3,PriceInfo);
   
   if((LastHigh!=PriceInfo[1].high) && (LastClose!=PriceInfo[1].low))
   {
      string mySpreadsheet = "Spreadsheet.csv";
      int mySpreadsheetHandle = FileOpen(mySpreadsheet,FILE_READ|FILE_WRITE|FILE_CSV|FILE_ANSI);
      FileSeek(mySpreadsheetHandle,0,SEEK_END);
      FileWrite(mySpreadsheetHandle,"Time Stamp",PriceInfo[1].time,"High",PriceInfo[1].high,"Low",PriceInfo[1].low);
      FileClose(mySpreadsheetHandle);
      LastHigh = PriceInfo[1].high;
      LastClose = PriceInfo[1].low;
      
   }
   
   Comment(
            "Last High: ",LastHigh,"\n",
            "Last Low: ",LastClose,"\n"
          );
   
     
  }
//+------------------------------------------------------------------+
