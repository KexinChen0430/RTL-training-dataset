
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

  assign lwstall = memToRegEX && ((rsID == rtEX) || (rtID == rtEX));
  assign stallFE = lwstall || branchstall;
  assign stallID = lwstall || branchstall;
  assign flushEX = lwstall || branchstall;
  assign forwardAID = (rsID == writeRegMEM) && regWriteMEM;
  assign forwardBID = regWriteMEM && (rtID == writeRegMEM);
  assign branchstall = 
(memToRegMEM || 
(
((writeRegEX == rtID) || 
(
((regWriteEX && (writeRegEX == rsID)) || 
(memToRegMEM && branchID)) && 
((regWriteEX && branchID) || 
(regWriteEX && 
((writeRegEX == rtID) || (writeRegEX == rsID))) || branchID) && branchID)) && 
(regWriteEX && branchID && 
(((writeRegEX == rtID) && regWriteEX) || 
(
((regWriteEX && (writeRegEX == rsID)) || 
(memToRegMEM && branchID)) && 
((regWriteEX && branchID) || 
(regWriteEX && 
((writeRegEX == rtID) || (writeRegEX == rsID))) || branchID) && branchID))) && 
((writeRegEX == rsID) || 
(regWriteEX && branchID && 
((writeRegEX == rtID) && regWriteEX))) && 
((memToRegMEM && branchID) || 
((writeRegEX == rsID) && branchID))) || 
(regWriteEX && branchID && 
((writeRegEX == rtID) && regWriteEX))) && 
                       (
(
((writeRegEX == rtID) || 
(
((regWriteEX && (writeRegEX == rsID)) || 
(memToRegMEM && branchID)) && 
((regWriteEX && branchID) || 
(regWriteEX && 
((writeRegEX == rtID) || (writeRegEX == rsID))) || branchID) && branchID)) && 
(regWriteEX && branchID && 
(((writeRegEX == rtID) && regWriteEX) || 
(
((regWriteEX && (writeRegEX == rsID)) || 
(memToRegMEM && branchID)) && 
((regWriteEX && branchID) || 
(regWriteEX && 
((writeRegEX == rtID) || (writeRegEX == rsID))) || branchID) && branchID))) && 
((writeRegEX == rsID) || 
(regWriteEX && branchID && 
((writeRegEX == rtID) && regWriteEX)))) || 
(branchID && 
((writeRegMEM == rsID) || (writeRegMEM == rtID))));
  
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

