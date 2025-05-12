
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

  assign lwstall = (((rsID == rtEX) && memToRegEX) || (rtID == rtEX)) && 
                   memToRegEX;
  assign stallFE = branchstall || lwstall;
  assign stallID = branchstall || lwstall;
  assign flushEX = branchstall || lwstall;
  assign forwardAID = (rsID == writeRegMEM) && regWriteMEM;
  assign forwardBID = regWriteMEM && (rtID == writeRegMEM);
  assign branchstall = 
(
(((writeRegMEM == rsID) || (writeRegMEM == rtID)) && 
branchID) || 
(branchID && 
(regWriteEX && 
((writeRegEX == rsID) || (writeRegEX == rtID))))) && 
                       (regWriteEX || 
(
(memToRegMEM && (branchID || regWriteEX) && branchID) || ((writeRegEX == rsID) && (regWriteEX && branchID)) || 
((writeRegEX == rsID) && (regWriteEX && branchID)))) && 
                       (
((writeRegEX == rsID) || (writeRegEX == rtID) || 
(
(
((regWriteEX && (writeRegEX == rtID)) || 
(memToRegMEM && (branchID || regWriteEX) && branchID)) && 
(branchID || 
(((writeRegEX == rsID) && (regWriteEX && branchID)) || 
(memToRegMEM && (branchID || regWriteEX) && branchID && 
(writeRegMEM == rsID)) || (writeRegEX == rtID))) && branchID) || 
(memToRegMEM && (branchID || regWriteEX) && branchID && 
(regWriteEX && 
((writeRegEX == rsID) || (writeRegEX == rtID)))) || 
(branchID && 
(regWriteEX && 
((writeRegEX == rsID) || (writeRegEX == rtID)))))) && 
(((writeRegEX == rsID) && branchID) || 
(
(regWriteEX && branchID && 
(branchID && (writeRegEX == rtID))) || (writeRegMEM == rsID) || (writeRegMEM == rtID))) && 
(((writeRegEX == rsID) && (regWriteEX && branchID)) || 
((writeRegMEM == rsID) || (writeRegMEM == rtID)) || (regWriteEX && branchID) || regWriteEX));
  
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

