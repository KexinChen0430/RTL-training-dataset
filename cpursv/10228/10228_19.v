
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
  assign StartNumb = (StateIdle & SystemStart) & PHYInitEnd;
  assign StartDist = NumbFrameReturned & StateWait;
  assign StartDelay = DistFrameReturned & StateWait;
  assign StartDelayDist = ((DelayFrameReturned & ((((ConfigEnd & DelayDistFrameReturned) | (StateWait & ConfigEnd)) | StateWait) | (DelayDistFrameReturned | ((((ConfigEnd & (DataFrameGo & StateWait)) | ((StateWait & (DelayDistFrameReturned & ((DelayDistFrameReturned | DataFrameGo) & (StateWait | (ConfigEnd & DataFrameGo))))) & (StateWait & ConfigEnd))) | (ConfigEnd & DelayDistFrameReturned)) | (DataFrameGo & DelayDistFrameReturned))))) & (StateWait | (ConfigEnd & DataFrameGo))) & StateWait;
  assign StartData = (DelayDistFrameReturned | ((((ConfigEnd & (DataFrameGo & StateWait)) | ((StateWait & (DelayDistFrameReturned & ((DelayDistFrameReturned | DataFrameGo) & (StateWait | (ConfigEnd & DataFrameGo))))) & (StateWait & ConfigEnd))) | (ConfigEnd & DelayDistFrameReturned)) | (DataFrameGo & DelayDistFrameReturned))) & (((DataFrameGo & StateWait) | DelayDistFrameReturned) & StateWait);
  assign StartWait = (StateDelayDist | StateDelay) | ((StateNumb | StateDist) | StateData);
  
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
              
            if ((StartDist | (StartData | StartDelay)) | (StartDelayDist | StartIdle)) StateWait <= 1'b0;
            else if (StartWait) StateWait <= 1'b1;
              
          end
      end
endmodule

