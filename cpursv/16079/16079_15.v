
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

  assign lwstall = ((rsID == rtEX) || ((rtID == rtEX) && memToRegEX)) && 
                   memToRegEX;
  assign stallFE = branchstall || lwstall;
  assign stallID = branchstall || lwstall;
  assign flushEX = branchstall || lwstall;
  assign forwardAID = regWriteMEM && (rsID == writeRegMEM);
  assign forwardBID = regWriteMEM && (rtID == writeRegMEM);
  assign branchstall = 
((writeRegMEM == rsID) || (writeRegMEM == rtID) || 
(branchID && (writeRegEX == rsID) && regWriteEX) || 
(regWriteEX && 
((regWriteEX && (writeRegEX == rtID)) || 
((writeRegEX == rsID) && regWriteEX) || branchID) && branchID)) && 
                       (
(regWriteEX && 
((regWriteEX && (writeRegEX == rtID)) || 
((writeRegEX == rsID) && regWriteEX) || branchID) && branchID) || (memToRegMEM && branchID)) && 
                       (
(memToRegMEM && branchID && 
(memToRegMEM && (writeRegMEM == rsID))) || 
((branchID && (writeRegEX == rsID) && regWriteEX) || 
(writeRegEX == rtID)) || (memToRegMEM && branchID)) && 
                       (
((writeRegEX == rtID) || 
((writeRegMEM == rtID) || 
((writeRegEX == rsID) || (writeRegMEM == rsID)))) && 
(
(regWriteEX && 
((regWriteEX && (writeRegEX == rtID)) || 
((writeRegEX == rsID) && regWriteEX) || branchID) && branchID) || (memToRegMEM && branchID)) && 
((memToRegMEM && branchID) || 
((writeRegEX == rsID) || 
(regWriteEX && (writeRegEX == rtID) && 
(
(regWriteEX && 
((regWriteEX && (writeRegEX == rtID)) || 
((writeRegEX == rsID) && regWriteEX) || branchID) && branchID) || (branchID && (writeRegEX == rsID)))) || 
(branchID && ((writeRegMEM == rtID) && memToRegMEM)))));
  
  always @* 
      begin
        if (regWriteMEM && (rsEX == writeRegMEM)) 
          begin
            forwardAEX <= 'b10;
          end
        else if (regWriteWB && (rsEX == writeRegWB)) 
          begin
            forwardAEX <= 'b01;
          end
        else 
          begin
            forwardAEX <= 'b00;
          end
        if ((rtEX == writeRegMEM) && regWriteMEM) 
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

