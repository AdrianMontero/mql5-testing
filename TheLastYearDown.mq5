#include <Trade\Trade.mqh>

CTrade trade;

input double myLotSize = 0.01;

void OnTick()
{
    Comment("total: ", PositionSelect(_Symbol));
    double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits); 
    //If position in this currency pair exist
    if (PositionSelect(_Symbol) == false)
     {
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
             if(PositionPriceOpen < (PositionPriceCurrent  + 5 * _Point)  && PositionPriceOpen > (PositionPriceCurrent  - 5 * _Point))
             {
                 newTrade = true;
             }
         }
         if(newTrade == true)
         {
             OpenShortTrade(bid);
         }
     }
}
  
  
void OpenShortTrade(double bid)
{      
      trade.Sell(myLotSize, NULL, bid, NULL, (bid - 10 * _Point), "Abierto en Corto");
}
