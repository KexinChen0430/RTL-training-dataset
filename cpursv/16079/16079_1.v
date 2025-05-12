
module HazardsUnit(input  branchID,
                   input  [4:0] rsID,
                   input  [4:0] rtID,
                   input  [4:0] rsEX,
                   input  [4:0] rtEX,
                   input  [4:0] writeRegEX,
                   input  [4:0] writeRegMEM,
                   input  [4:0] writeRegWB,
                   input  memToRegEX,
                   input  memToRegMEM,
                   input  regWriteEX,
                   input  regWriteMEM,
                   input  regWriteWB,
                   output stallFE,
                   output stallID,
                   output forwardAID,
                   output forwardBID,
                   output flushEX,
                   output reg [1:0] forwardAEX,
                   output reg [1:0] forwardBEX);

  wire lwstall;
  wire branchstall;

  assign lwstall = (memToRegEX && (rsID == rtEX)) || 
                   ((rtID == rtEX) && memToRegEX);
  assign stallFE = branchstall || lwstall;
  assign stallID = branchstall || lwstall;
  assign flushEX = branchstall || lwstall;
  assign forwardAID = (rsID == writeRegMEM) && regWriteMEM;
  assign forwardBID = (rtID == writeRegMEM) && regWriteMEM;
  assign branchstall = 
(branchID && regWriteEX && 
(regWriteEX && (writeRegEX == rsID))) || 
                       ((writeRegMEM == rsID) && 
(memToRegMEM && ((writeRegEX == rsID) || branchID) && 
branchID)) || 
                       ((memToRegMEM && (writeRegMEM == rtID) && branchID) || 
(regWriteEX && ((writeRegEX == rtID) && branchID)));
  
  always @* 
      begin
        if ((rsEX == writeRegMEM) && regWriteMEM) 
          begin
            forwardAEX <= 'b10;
          end
        else if ((rsEX == writeRegWB) && regWriteWB) 
          begin
            forwardAEX <= 'b01;
          end
        else 
          begin
            forwardAEX <= 'b00;
          end
        if (regWriteMEM && (rtEX == writeRegMEM)) 
          begin
            forwardBEX <= 'b10;
          end
        else if ((rtEX == writeRegWB) && regWriteWB) 
          begin
            forwardBEX <= 'b01;
          end
        else 
          begin
            forwardBEX <= 'b00;
          end
      end
endmodule

