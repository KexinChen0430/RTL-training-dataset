
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

  assign lwstall = memToRegEX && 
                   ((memToRegEX && (rtID == rtEX)) || (rsID == rtEX));
  assign stallFE = branchstall || lwstall;
  assign stallID = branchstall || lwstall;
  assign flushEX = branchstall || lwstall;
  assign forwardAID = regWriteMEM && (rsID == writeRegMEM);
  assign forwardBID = regWriteMEM && (rtID == writeRegMEM);
  assign branchstall = 
(branchID && memToRegMEM && 
((memToRegMEM && (writeRegMEM == rsID) && branchID) || 
(writeRegMEM == rtID) || ((writeRegEX == rtID) && (branchID && regWriteEX)) || 
(branchID && regWriteEX)) && 
((writeRegMEM == rsID) || 
(memToRegMEM && (writeRegMEM == rtID) && branchID))) || ((writeRegEX == rtID) && (branchID && regWriteEX)) || 
                       ((writeRegEX == rsID) && 
(memToRegMEM || (branchID && regWriteEX)) && 
((branchID && regWriteEX) || 
(((writeRegEX == rtID) && (branchID && regWriteEX)) || 
(branchID && 
((writeRegEX == rsID) || 
((writeRegEX == rtID) || 
((writeRegMEM == rtID) || (writeRegMEM == rsID)))) && ((writeRegMEM == rtID) || (writeRegMEM == rsID))))));
  
  always @* 
      begin
        if (regWriteMEM && (rsEX == writeRegMEM)) 
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

