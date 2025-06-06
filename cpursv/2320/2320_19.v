
module HeaderTrailer(input  Sdat,
                     input  CLK,
                     input  Trailer_OLD_NEW_0_1,
                     output reg TBM_HEADER,
                     output reg ROC_HEADER,
                     output reg TBM_TRAILER,
                     output reg gate,
                     output sdo);

  reg  start;
  reg  [4:0] delay;
  wire  veto = delay != 0;
  reg  [14:0] shift;

  
  always @(posedge CLK)  shift <= {shift[13:0],Sdat};
  wire [8:0]  leader = shift[11:3];

  wire [1+1:0]  id = shift[3:1];

  assign sdo = shift[14];
  
  always @(posedge CLK)
      start <= !veto && (leader == 9'b011111111);
  
  always @(posedge CLK)
      begin
        if (TBM_HEADER || TBM_TRAILER) delay <= 22;
        else if (veto) delay <= delay-1;
          
      end
  
  always @(posedge CLK)
      begin
        TBM_HEADER <= (id == 3'b100) && start;
        TBM_TRAILER <= (id == {2'b11,~Trailer_OLD_NEW_0_1}) && start;
        ROC_HEADER <= start && !id[1+1];
      end
  
  always @(posedge CLK)
      begin
        if (TBM_HEADER) gate <= 1;
        else if (TBM_TRAILER) gate <= 0;
          
      end
endmodule

