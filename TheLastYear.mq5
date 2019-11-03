#include <Trade\Trade.mqh>

CTrade trade;

input double myLotSize = 0.01;
input double myMeshDistance = 0.002;
input double myTP = 0.0001;
input double myBalanceSecurity = 0.6;

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
             if(PositionPriceOpen < (PositionPriceCurrent  + myMeshDistance)  && PositionPriceOpen > (PositionPriceCurrent  - myMeshDistance))
             {
                 newTrade = false;
             }
         }
         if(newTrade == true && (myEquity >= (myBalance * myBalanceSecurity)))
         {
             OpenLongTrade(ask);
             OpenShortTrade(bid);
         }
     }
}
  
  
void OpenLongTrade(double ask)
{      
      trade.Buy(myLotSize, NULL, ask, NULL, (ask + myTP), "Abierto en Largo");
}

void OpenShortTrade(double bid)
{      
      trade.Sell(myLotSize, NULL, bid, NULL, (bid - myTP), "Abierto en Corto");
}
