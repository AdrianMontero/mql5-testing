#include <Trade\Trade.mqh>

CTrade trade;

input double myLotSize = 0.01;
input double myMeshDistance = 0.0007;
input double myTP = 0.0001;
input double myBalanceSecurity = 0.5;
input double myReinversionSecurity = 3;
input int maxContador = 256;
input double riskForceEquityLvlOne = 0.95;
input double riskForceEquityLvlTwo = 0.90;
input double riskForceEquityLvlThree = 0.80;
input double riskForceEquityLvlFour = 0.75;
input double riskForceMultiplicatorLvlOne = 1.2;
input double riskForceMultiplicatorLvlTwo = 1.5;
input double riskForceMultiplicatorLvlThree = 2;
input double riskForceMultiplicatorLvlFour = 2.5;
input bool tradeInLong = false;
input bool tradeInShort = true;
input bool riskForce = true;
double myInitInversion = AccountInfoDouble(ACCOUNT_BALANCE);
double myLocalLotSize = myLotSize;
double myEquity = 0;
double myBalance = 0;
string lotValue = "";
void OnTick()
{
    myBalance = AccountInfoDouble(ACCOUNT_BALANCE);
    myEquity = AccountInfoDouble(ACCOUNT_EQUITY);
    double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits); 
    double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
    double lot = myLocalLotSize;    
 int contador = maxContador;
 while(myEquity <= (myInitInversion + (myInitInversion / myReinversionSecurity)) * contador)
 {
    contador = contador / 2;
 }
 contador = contador * 2;
 if(contador <= 2)contador = 1;
 if(riskForce) //riskForce Code
 {
    if(myEquity <= (myBalance * riskForceEquityLvlOne))lot = lot * riskForceMultiplicatorLvlOne * contador;
    if(myEquity <= (myBalance * riskForceEquityLvlTwo))lot = lot * riskForceMultiplicatorLvlTwo * contador;
    if(myEquity <= (myBalance * riskForceEquityLvlThree))lot = lot * riskForceMultiplicatorLvlThree * contador;
    if(myEquity <= (myBalance * riskForceEquityLvlFour))lot = lot * riskForceMultiplicatorLvlFour * contador;
    if(myEquity >= (myBalance * riskForceEquityLvlOne))lot = lot * contador;
 }else lot = lot * contador;
    if (PositionSelect(_Symbol) == false) // First trade code
     {
         if(tradeInLong)
         {
            OpenLongTrade(ask, lot);
         }
         if(tradeInShort)
         {
            OpenShortTrade(bid, lot);
         }
     }
    if (PositionSelect(_Symbol) == true) //Bot Logic
     {
         bool newShortTrade = true; 
         bool newLongTrade = true;
         // Count down the number of positions until zero
         for(int i=PositionsTotal() - 1; i >= 0; i--)
         {
           //calculate the needed values
             //Calculate the ticket number
             long PositionTicket = PositionGetTicket(i);
             //Calculate the open price for the position
             double PositionPriceOpen = PositionGetDouble(POSITION_PRICE_OPEN);
             //Calculate the current position price
             double PositionPriceCurrent = PositionGetDouble(POSITION_PRICE_CURRENT);
             //Look the direction of the trade
             int PositionType = PositionGetInteger(POSITION_TYPE);
             //If the position is in range with the current ask
             if(PositionPriceOpen < (PositionPriceCurrent  + myMeshDistance)  && PositionPriceOpen > (PositionPriceCurrent  - myMeshDistance))
             {
                 if(PositionType == 0) //BUY
                 {
                     newLongTrade = false;
                 }
                 if(PositionType == 1) //SELL
                 {
                     newShortTrade = false;
                 }
             }
         }
         if(myEquity >= (myBalance * myBalanceSecurity))
         {
         
             if(newLongTrade == true && tradeInLong)
             {
                 OpenLongTrade(ask, lot);
             }
         
             if(newShortTrade == true && tradeInShort)
             {
                 OpenShortTrade(bid, lot);
             }
         }
     }
}
void OpenLongTrade(double ask, double lot)
{      
      trade.Buy(lot, NULL, ask, NULL, (ask + myTP), ("long-" + lotValue));
      Comment("long", lotValue);
}

void OpenShortTrade(double bid, double lot)
{      
      trade.Sell(lot, NULL, bid, NULL, (bid - myTP), ("short-" + lotValue));
      Comment("short:", lotValue);
}
