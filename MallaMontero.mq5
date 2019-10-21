//+------------------------------------------------------------------+
//|                                                 MallaMontero.mq5 |
//|                             Adrian Montero de Espinosa Gutierrez |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>
CTrade trade;


//INPUTS
input double meshTradeRange = 0.00001; //Distancia entre los diferentes trades que vamos a abrir
input double myLotSize = 0.01; //Volumen del lote que vamos a comprar (0.01 es el minimo)

MqlRates PriceInformation[];
double initAsk = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
double initBid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
input double meshTrade = 0.01;
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
      "\n initAsk: ", initAsk,
      "\n initBid: ", initBid,
      "\n Ask: ", ask,
      "\n Bid: ", bid,
      "\n Balance: ", myAccountBalance, 
      "\n Profit: ", myAccountProfit, 
      "\n Equity: ", myAccountEquity,
      "\n Price is going Up");
   }
   
   if(PriceInformation[1].close < PriceInformation[2].close){
      Comment( 
      "\n initAsk: ", initAsk,
      "\n initBid: ", initBid,
      "\n Ask: ", ask,
      "\n Bid: ", bid,
      "\n Balance: ", myAccountBalance, 
      "\n Profit: ", myAccountProfit, 
      "\n Equity: ", myAccountEquity,
      "\n Price is going Down");
   }
//Logica
/**
   if(initBid < (bid - 8 * _Point)){
      openShortTrade(bid, myAccountEquity, myAccountBalance);
      initBid = bid;
      initAsk = ask;
   }
   if(initAsk > (ask + 8 * _Point)){
      openLongTrade(ask, myAccountEquity, myAccountBalance); 
      initBid = bid;
      initAsk = ask;
   }
**/
   
//Logica v2
   if(initAsk < ask + meshTrade){
      openLongTrade(ask, myAccountEquity, myAccountBalance);
      initBid = bid;
      initAsk = ask;
   }
   if(initBid +  meshTrade < bid){
      openShortTrade(bid, myAccountEquity, myAccountBalance);
      initBid = bid;
      initAsk = ask;
   }
   if(initAsk - meshTrade > ask){
      openLongTrade(ask, myAccountEquity, myAccountBalance);
      initBid = bid;
      initAsk = ask;
   }
   if(initBid > bid - meshTrade){
      openShortTrade(bid, myAccountEquity, myAccountBalance);
      initBid = bid;
      initAsk = ask;
   }
}
  
void openShortTrade(double bid, double myAccountEquity, double myAccountBalance)
   {
      //if(myAccountEquity >= myAccountBalance){
         trade.Sell(myLotSize, NULL, bid, NULL, (bid - meshTrade), "Abierto en corto");
      //}
   }
   
void openLongTrade(double ask, double myAccountEquity, double myAccountBalance)
   {      
      //if(myAccountEquity >= myAccountBalance){
         trade.Buy(myLotSize, NULL, ask, NULL, (ask + meshTrade), "Abierto en Largo");
      //}
   }
   
void CloseAllOrders(){
   int i;
   i = PositionsTotal() - 1;
   while (i >= 0){
      if(trade.PositionClose(PositionGetSymbol(i))) i--;
   }
   i = PositionsTotal() - 1;
      while (i >= 0){
      if(trade.PositionClose(PositionGetSymbol(i))) i--;
   }
}
