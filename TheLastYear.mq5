#include <Trade\Trade.mqh>

CTrade trade;

input double myLotSize = 0.01;
input int myMeshDistanceInPips = 5;
input int myTPInPips = 10;
input int myBalanceSecurity = 3;

void OnTick()
{
    double myBalance = AccountInfoDouble(ACCOUNT_BALANCE);
    double myEquity = AccountInfoDouble(ACCOUNT_EQUITY); 
    double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits); 
    double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits); 
    //If position in this currency pair exist
    if (PositionSelect(_Symbol) == false)
     {
         OpenLongTrade(ask);
         OpenShortTrade(bid);
     }
    if (PositionSelect(_Symbol) == true)
     {
         bool newTrade = true; 
         // Count down the number of positions until zero
         for(int i=PositionsTotal() - 1; i >= 0; i--)
         {
           //calculate the needed values
             //Calculate the ticket number
             ulong PositionTicket = PositionGetTicket(i);
             //Calculate the open price for the position
             double PositionPriceOpen = PositionGetDouble(POSITION_PRICE_OPEN);
             //Calculate the current position price
             double PositionPriceCurrent = PositionGetDouble(POSITION_PRICE_CURRENT);
             //If the position is in range with the current ask
             if(PositionPriceOpen < (PositionPriceCurrent  + myMeshDistanceInPips * _Point)  && PositionPriceOpen > (PositionPriceCurrent  - myMeshDistanceInPips * _Point))
             {
                 newTrade = true;
             }
         }
         if(newTrade == true && (myEquity >= (myBalance / myBalanceSecurity)))
         {
             OpenLongTrade(ask);
             OpenShortTrade(bid);
         }
     }
}
  
  
void OpenLongTrade(double ask)
{      
      trade.Buy(myLotSize, NULL, ask, NULL, (ask + myTPInPips * _Point), "Abierto en Largo");
}

void OpenShortTrade(double bid)
{      
      trade.Sell(myLotSize, NULL, bid, NULL, (bid - myTPInPips * _Point), "Abierto en Corto");
}
