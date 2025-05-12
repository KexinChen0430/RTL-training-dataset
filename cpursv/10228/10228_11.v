
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
  assign StartNumb = (PHYInitEnd & SystemStart) & StateIdle;
  assign StartDist = StateWait & NumbFrameReturned;
  assign StartDelay = ((((((StateWait & ConfigEnd) | (DataFrameGo & ConfigEnd)) | StateWait) | DelayDistFrameReturned) | ((DelayDistFrameReturned | (((DataFrameGo & (StateWait & ConfigEnd)) | ((DataFrameGo & DelayDistFrameReturned) & (StateWait & DelayDistFrameReturned))) | (((DataFrameGo & ((StateWait & DelayDistFrameReturned) & ConfigEnd)) | ((StateWait & DelayDistFrameReturned) & ConfigEnd)) | (ConfigEnd & DelayDistFrameReturned)))) | ((((ConfigEnd & DelayDistFrameReturned) | (DataFrameGo & ConfigEnd)) | (StateWait & DelayDistFrameReturned)) | ConfigEnd))) & DistFrameReturned) & StateWait;
  assign StartDelayDist = StateWait & ((StateWait | (((StateWait & DelayDistFrameReturned) | (StateWait & ConfigEnd)) | DataFrameGo)) & DelayFrameReturned);
  assign StartData = (((ConfigEnd & DelayDistFrameReturned) | (DataFrameGo & ConfigEnd)) | (StateWait & DelayDistFrameReturned)) & ((DataFrameGo & StateWait) | (StateWait & DelayDistFrameReturned));
  assign StartWait = (StateDist | StateNumb) | ((StateData | StateDelayDist) | StateDelay);
  
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
              
            if (StartDelayDist | ((StartDist | StartIdle) | (StartDelay | StartData))) StateWait <= 1'b0;
            else if (StartWait) StateWait <= 1'b1;
              
          end
      end
endmodule

