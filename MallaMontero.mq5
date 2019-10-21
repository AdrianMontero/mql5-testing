//+------------------------------------------------------------------+
//|                                                 MallaMontero.mq5 |
//|                             Adrian Montero de Espinosa Gutierrez |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>
CTrade trade;

//INPUTS
input double myLotSize = 0.10;

int OnInit()
  {
   return(INIT_SUCCEEDED);
  }

void OnTick()
  {
   MqlRates PriceInformation[];
   ArraySetAsSeries(PriceInformation, true);
   int Data = CopyRates(Symbol(), Period(), 0, Bars(Symbol(), Period()), PriceInformation);
   double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits); 
   double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   double myAccountBalance = AccountInfoDouble(ACCOUNT_BALANCE);
   double myAccountProfit = AccountInfoDouble(ACCOUNT_PROFIT);
   double myAccountEquity = AccountInfoDouble(ACCOUNT_EQUITY);   
   
//Informacion en pantalla
   if(PriceInformation[1].close > PriceInformation[2].close) {     
      Comment( 
      "\n Ask: ", ask,
      "\n Bid: ", bid,
      "\n Balance: ", myAccountBalance, 
      "\n Profit: ", myAccountProfit, 
      "\n Equity: ", myAccountEquity,
      "\n Price is going Up");
   }
   
   if(PriceInformation[1].close < PriceInformation[2].close){
      Comment( 
      "\n Ask: ", ask,
      "\n Bid: ", bid,
      "\n Balance: ", myAccountBalance, 
      "\n Profit: ", myAccountProfit, 
      "\n Equity: ", myAccountEquity,
      "\n Price is going Down");
   }
//Logica

}
  
void openShortTrade(double bid, double myAccountEquity, double myAccountBalance)
   {
      if(myAccountEquity >= myAccountBalance){
         trade.Sell(myLotSize, NULL, bid, 0, (bid - 100 * _Point), NULL);
      }
   }
   
void openLongTrade(double ask, double myAccountEquity, double myAccountBalance)
   {      
      if(myAccountEquity >= myAccountBalance){
         trade.Buy(myLotSize, NULL, ask, 0, (ask + 100 * _Point), NULL);
      }
   }
   
void CloseAllOrders(){
   int i = PositionsTotal() - 1;
   while (i >= 0){
      if(trade.PositionClose(PositionGetSymbol(i))) i--;
   }
}
