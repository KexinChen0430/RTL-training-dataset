
module fb_topstatem(clk_top,rst,SystemEnd,SystemStart,PHYInitEnd,
                    NumbFrameReturned,DistFrameReturned,DelayFrameReturned,
                    DelayDistFrameReturned,ConfigEnd,DataFrameGo,StateIdle,
                    StateNumb,StateDist,StateDelay,StateDelayDist,StateData,
                    StateWait);

  input  clk_top;
  input  rst;
  input  SystemEnd;
  input  SystemStart;
  input  PHYInitEnd;
  input  NumbFrameReturned;
  input  DistFrameReturned;
  input  DelayFrameReturned;
  input  DelayDistFrameReturned;
  input  ConfigEnd;
  input  DataFrameGo;
  output reg StateIdle;
  output reg StateNumb;
  output reg StateDist;
  output reg StateDelay;
  output reg StateDelayDist;
  output reg StateData;
  output reg StateWait;
  wire StartIdle;
  wire StartNumb;
  wire StartDist;
  wire StartDelay;
  wire StartDelayDist;
  wire StartData;
  wire StartWait;

  assign StartIdle = SystemEnd;
  assign StartNumb = (PHYInitEnd & StateIdle) & SystemStart;
  assign StartDist = ((((StateWait | ConfigEnd) & (DataFrameGo & (ConfigEnd | (DelayDistFrameReturned & DataFrameGo)))) | StateWait) & (((((((StateWait & DataFrameGo) | (DelayDistFrameReturned & ConfigEnd)) | DelayDistFrameReturned) & (ConfigEnd & StateWait)) | (DelayDistFrameReturned | (((DelayDistFrameReturned & ConfigEnd) | ((StateWait & DelayDistFrameReturned) & ((DelayDistFrameReturned & ConfigEnd) & DataFrameGo))) | ((StateWait & DataFrameGo) & (ConfigEnd & StateWait))))) | StateWait) & (NumbFrameReturned & (((((ConfigEnd & StateWait) | ((StateWait & DelayDistFrameReturned) | (((StateWait & DataFrameGo) & DelayDistFrameReturned) | ((StateWait & DataFrameGo) & (ConfigEnd & StateWait))))) | ((((StateWait & DataFrameGo) & DelayDistFrameReturned) | ((StateWait & DataFrameGo) & (ConfigEnd & StateWait))) | ConfigEnd)) | (((DelayDistFrameReturned & ConfigEnd) | (ConfigEnd & StateWait)) | DelayDistFrameReturned)) | (StateWait | ConfigEnd))))) & StateWait;
  assign StartDelay = StateWait & DistFrameReturned;
  assign StartDelayDist = StateWait & (((((((ConfigEnd & StateWait) | ((StateWait & DelayDistFrameReturned) | (((StateWait & DataFrameGo) & DelayDistFrameReturned) | ((StateWait & DataFrameGo) & (ConfigEnd & StateWait))))) | ((((StateWait & DataFrameGo) & DelayDistFrameReturned) | ((StateWait & DataFrameGo) & (ConfigEnd & StateWait))) | ConfigEnd)) | (((DelayDistFrameReturned & ConfigEnd) | (ConfigEnd & StateWait)) | DelayDistFrameReturned)) | (StateWait | ConfigEnd)) & DelayFrameReturned) & ((((((StateWait & DataFrameGo) | (DelayDistFrameReturned & ConfigEnd)) | DelayDistFrameReturned) & (ConfigEnd & StateWait)) | (DelayDistFrameReturned | (((DelayDistFrameReturned & ConfigEnd) | ((StateWait & DelayDistFrameReturned) & ((DelayDistFrameReturned & ConfigEnd) & DataFrameGo))) | ((StateWait & DataFrameGo) & (ConfigEnd & StateWait))))) | StateWait));
  assign StartData = (StateWait & DelayDistFrameReturned) | (((StateWait & DataFrameGo) & DelayDistFrameReturned) | ((StateWait & DataFrameGo) & (ConfigEnd & StateWait)));
  assign StartWait = ((StateNumb | StateDelayDist) | (StateDist | StateDelay)) | StateData;
  
  always @(posedge clk_top or posedge rst)
      begin
        if (rst) 
          begin
            StateIdle <= 1'b1;
            StateNumb <= 1'b0;
            StateDist <= 1'b0;
            StateDelay <= 1'b0;
            StateDelayDist <= 1'b0;
            StateData <= 1'b0;
            StateWait <= 1'b0;
          end
        else 
          begin
            if (StartNumb) StateIdle <= 1'b0;
            else if (StartIdle) StateIdle <= 1'b1;
              
            if (StartIdle | StartWait) StateNumb <= 1'b0;
            else if (StartNumb) StateNumb <= 1'b1;
              
            if (StartIdle | StartWait) StateDist <= 1'b0;
            else if (StartDist) StateDist <= 1'b1;
              
            if (StartIdle | StartWait) StateDelay <= 1'b0;
            else if (StartDelay) StateDelay <= 1'b1;
              
            if (StartIdle | StartWait) StateDelayDist <= 1'b0;
            else if (StartDelayDist) StateDelayDist <= 1'b1;
              
            if (StartIdle | StartWait) StateData <= 1'b0;
            else if (StartData) StateData <= 1'b1;
              
            if ((StartIdle | StartDist) | (StartDelay | (StartData | StartDelayDist))) StateWait <= 1'b0;
            else if (StartWait) StateWait <= 1'b1;
              
          end
      end
endmodule

