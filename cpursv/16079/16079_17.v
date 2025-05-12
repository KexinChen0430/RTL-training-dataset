
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

  assign lwstall = ((rsID == rtEX) || (rtID == rtEX)) && memToRegEX;
  assign stallFE = lwstall || branchstall;
  assign stallID = lwstall || branchstall;
  assign flushEX = lwstall || branchstall;
  assign forwardAID = (rsID == writeRegMEM) && regWriteMEM;
  assign forwardBID = regWriteMEM && (rtID == writeRegMEM);
  assign branchstall = 
(
(regWriteEX && 
((writeRegEX == rtID) && branchID && 
((branchID && (regWriteEX && (writeRegEX == rsID))) || 
((writeRegMEM == rsID) && (memToRegMEM && branchID)) || (memToRegMEM && branchID) || (branchID && regWriteEX)) && 
((writeRegEX == rsID) || (writeRegEX == rtID) || 
(memToRegMEM && branchID)))) || 
(memToRegMEM || 
((branchID && (regWriteEX && (writeRegEX == rsID))) || 
((writeRegMEM == rtID) && (memToRegMEM && branchID))))) && 
                       ((branchID && (regWriteEX && (writeRegEX == rsID))) || 
(
(branchID && 
((writeRegMEM == rtID) || (writeRegEX == rtID) || 
(writeRegMEM == rsID) || (writeRegEX == rsID)) && ((writeRegMEM == rsID) || (writeRegMEM == rtID))) || 
(
((memToRegMEM && branchID) || 
(regWriteEX && (writeRegEX == rtID))) && branchID && (branchID && regWriteEX) && 
(((writeRegEX == rtID) || (branchID && regWriteEX)) && 
((writeRegEX == rsID) || (writeRegEX == rtID))))));
  
  always @* 
      begin
        if ((rsEX == writeRegMEM) && regWriteMEM) 
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

