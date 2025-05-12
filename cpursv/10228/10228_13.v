
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
  assign StartNumb = PHYInitEnd & (SystemStart & StateIdle);
  assign StartDist = (NumbFrameReturned & ((StateWait | ((DelayDistFrameReturned & ConfigEnd) | (DataFrameGo & DelayDistFrameReturned))) | DelayDistFrameReturned)) & StateWait;
  assign StartDelay = StateWait & ((((StateWait | ((DelayDistFrameReturned & ConfigEnd) | (DataFrameGo & DelayDistFrameReturned))) | DelayDistFrameReturned) & DistFrameReturned) & ((StateWait | (((((StateWait & (ConfigEnd & ((StateWait & DataFrameGo) | DelayDistFrameReturned))) | ((StateWait & DataFrameGo) & (DelayDistFrameReturned | ConfigEnd))) | (DelayDistFrameReturned & ((DelayDistFrameReturned | ConfigEnd) & StateWait))) | ((((DelayDistFrameReturned & (((ConfigEnd & StateWait) | DataFrameGo) | StateWait)) & (((((DelayDistFrameReturned & ConfigEnd) | (((StateWait & DataFrameGo) & (ConfigEnd & ((StateWait & DataFrameGo) | DelayDistFrameReturned))) & DelayDistFrameReturned)) | (StateWait & (DataFrameGo & DelayDistFrameReturned))) | (DelayDistFrameReturned & ((DelayDistFrameReturned | ConfigEnd) & StateWait))) | (ConfigEnd | (StateWait & (DataFrameGo & DelayDistFrameReturned))))) | ((DataFrameGo & ConfigEnd) | ((ConfigEnd & StateWait) & DelayDistFrameReturned))) & ((DataFrameGo & ConfigEnd) | (DataFrameGo & DelayDistFrameReturned)))) | StateWait)) | ((DelayDistFrameReturned & (((ConfigEnd & StateWait) | DataFrameGo) | StateWait)) & (((((DelayDistFrameReturned & ConfigEnd) | (((StateWait & DataFrameGo) & (ConfigEnd & ((StateWait & DataFrameGo) | DelayDistFrameReturned))) & DelayDistFrameReturned)) | (StateWait & (DataFrameGo & DelayDistFrameReturned))) | (DelayDistFrameReturned & ((DelayDistFrameReturned | ConfigEnd) & StateWait))) | (ConfigEnd | (StateWait & (DataFrameGo & DelayDistFrameReturned)))))));
  assign StartDelayDist = (DelayFrameReturned & ((StateWait | (((((StateWait & (ConfigEnd & ((StateWait & DataFrameGo) | DelayDistFrameReturned))) | ((StateWait & DataFrameGo) & (DelayDistFrameReturned | ConfigEnd))) | (DelayDistFrameReturned & ((DelayDistFrameReturned | ConfigEnd) & StateWait))) | ((((DelayDistFrameReturned & (((ConfigEnd & StateWait) | DataFrameGo) | StateWait)) & (((((DelayDistFrameReturned & ConfigEnd) | (((StateWait & DataFrameGo) & (ConfigEnd & ((StateWait & DataFrameGo) | DelayDistFrameReturned))) & DelayDistFrameReturned)) | (StateWait & (DataFrameGo & DelayDistFrameReturned))) | (DelayDistFrameReturned & ((DelayDistFrameReturned | ConfigEnd) & StateWait))) | (ConfigEnd | (StateWait & (DataFrameGo & DelayDistFrameReturned))))) | ((DataFrameGo & ConfigEnd) | ((ConfigEnd & StateWait) & DelayDistFrameReturned))) & ((DataFrameGo & ConfigEnd) | (DataFrameGo & DelayDistFrameReturned)))) | StateWait)) | ((DelayDistFrameReturned & (((ConfigEnd & StateWait) | DataFrameGo) | StateWait)) & (((((DelayDistFrameReturned & ConfigEnd) | (((StateWait & DataFrameGo) & (ConfigEnd & ((StateWait & DataFrameGo) | DelayDistFrameReturned))) & DelayDistFrameReturned)) | (StateWait & (DataFrameGo & DelayDistFrameReturned))) | (DelayDistFrameReturned & ((DelayDistFrameReturned | ConfigEnd) & StateWait))) | (ConfigEnd | (StateWait & (DataFrameGo & DelayDistFrameReturned))))))) & StateWait;
  assign StartData = ((StateWait & (ConfigEnd & ((StateWait & DataFrameGo) | DelayDistFrameReturned))) | ((StateWait & DataFrameGo) & (DelayDistFrameReturned | ConfigEnd))) | (DelayDistFrameReturned & ((DelayDistFrameReturned | ConfigEnd) & StateWait));
  assign StartWait = ((StateNumb | StateDelay) | StateDist) | (StateDelayDist | StateData);
  
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
              
            if (StartWait | StartIdle) StateNumb <= 1'b0;
            else if (StartNumb) StateNumb <= 1'b1;
              
            if (StartWait | StartIdle) StateDist <= 1'b0;
            else if (StartDist) StateDist <= 1'b1;
              
            if (StartWait | StartIdle) StateDelay <= 1'b0;
            else if (StartDelay) StateDelay <= 1'b1;
              
            if (StartWait | StartIdle) StateDelayDist <= 1'b0;
            else if (StartDelayDist) StateDelayDist <= 1'b1;
              
            if (StartWait | StartIdle) StateData <= 1'b0;
            else if (StartData) StateData <= 1'b1;
              
            if (((StartData | StartDelay) | (StartIdle | StartDist)) | StartDelayDist) StateWait <= 1'b0;
            else if (StartWait) StateWait <= 1'b1;
              
          end
      end
endmodule

