
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
                   (memToRegEX && (rtID == rtEX));
  assign stallFE = lwstall || branchstall;
  assign stallID = lwstall || branchstall;
  assign flushEX = lwstall || branchstall;
  assign forwardAID = (rsID == writeRegMEM) && regWriteMEM;
  assign forwardBID = (rtID == writeRegMEM) && regWriteMEM;
  assign branchstall = 
(
((writeRegEX == rtID) && branchID && 
(regWriteEX && branchID)) || 
(
((writeRegMEM == rsID) && 
(branchID || 
((writeRegEX == rsID) || (regWriteEX && branchID))) && branchID) || 
((writeRegMEM == rtID) && 
(branchID || 
((writeRegEX == rsID) || (regWriteEX && branchID))) && branchID)) || 
(
((memToRegMEM && branchID) || (writeRegEX == rsID)) && 
((memToRegMEM && branchID) || (regWriteEX && branchID)) && 
(regWriteEX && branchID && 
(
(memToRegMEM && (writeRegMEM == rsID) && 
(memToRegMEM && branchID)) || 
((writeRegEX == rtID) && branchID && 
(regWriteEX && branchID)) || (memToRegMEM && branchID) || 
(branchID && (writeRegEX == rsID))) && ((memToRegMEM && branchID) || regWriteEX)) && ((writeRegEX == rsID) || (writeRegEX == rtID)))) && ((memToRegMEM && branchID) || regWriteEX) && 
                       ((writeRegEX == rsID) || (writeRegEX == rtID) || 
(memToRegMEM && (writeRegMEM == rsID) && 
(memToRegMEM && branchID)) || (memToRegMEM && branchID));
  
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

