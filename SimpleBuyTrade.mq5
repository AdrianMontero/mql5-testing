#include <Trade\Trade.mqh>

CTrade trade;

input double myLotSize = 0.10;

void OnTick()
   {
      double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits); 
      double myBalance = AccountInfoDouble(ACCOUNT_BALANCE);
      double myProfit = AccountInfoDouble(ACCOUNT_PROFIT);
      double myEquity = AccountInfoDouble(ACCOUNT_EQUITY); 
      
      
      if(myEquity >= myBalance){
         trade.Sell(myLotSize, NULL, ask, 0, (ask + 100 * _Point), NULL);
      }
   }