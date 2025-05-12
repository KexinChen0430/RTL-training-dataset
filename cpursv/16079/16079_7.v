
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

  assign lwstall = memToRegEX && ((rtID == rtEX) || (rsID == rtEX));
  assign stallFE = lwstall || branchstall;
  assign stallID = lwstall || branchstall;
  assign flushEX = lwstall || branchstall;
  assign forwardAID = regWriteMEM && (rsID == writeRegMEM);
  assign forwardBID = (rtID == writeRegMEM) && regWriteMEM;
  assign branchstall = 
(regWriteEX && (writeRegEX == rsID) && 
(regWriteEX && branchID)) || 
                       (((writeRegMEM == rsID) || (writeRegMEM == rtID)) && 
(regWriteEX || (memToRegMEM && branchID)) && 
(branchID && 
((regWriteEX && (writeRegEX == rsID)) || 
(writeRegEX == rtID)) && 
(regWriteEX && branchID && 
((writeRegMEM == rsID) || (writeRegMEM == rtID) || 
(regWriteEX && (writeRegEX == rtID)) || 
(regWriteEX && (writeRegEX == rsID) && 
(regWriteEX && branchID))) && 
((writeRegMEM == rtID) || 
((writeRegMEM == rsID) || 
(regWriteEX && (writeRegEX == rsID) && 
(regWriteEX && branchID))) || 
((writeRegMEM == rsID) && 
((writeRegEX == rsID) || branchID) && branchID && (memToRegMEM && branchID)) || branchID)))) || 
                       (((writeRegMEM == rsID) || (writeRegMEM == rtID)) && 
branchID && 
(memToRegMEM && 
((writeRegEX == rtID) || 
((writeRegMEM == rsID) && 
((writeRegEX == rsID) || branchID) && branchID && (memToRegMEM && branchID)) || (writeRegEX == rsID) || (memToRegMEM && branchID)) && 
((writeRegEX == rtID) || 
((writeRegEX == rsID) || (writeRegMEM == rtID)) || 
((writeRegMEM == rsID) && 
((writeRegEX == rsID) || branchID) && branchID && (memToRegMEM && branchID))) && branchID)) || 
                       (branchID && 
((regWriteEX && (writeRegEX == rsID)) || 
(writeRegEX == rtID)) && 
(regWriteEX && branchID && 
((writeRegMEM == rsID) || (writeRegMEM == rtID) || 
(regWriteEX && (writeRegEX == rtID)) || 
(regWriteEX && (writeRegEX == rsID) && 
(regWriteEX && branchID))) && 
((writeRegMEM == rtID) || 
((writeRegMEM == rsID) || 
(regWriteEX && (writeRegEX == rsID) && 
(regWriteEX && branchID))) || 
((writeRegMEM == rsID) && 
((writeRegEX == rsID) || branchID) && branchID && (memToRegMEM && branchID)) || branchID)));
  
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
        else if (regWriteWB && (rtEX == writeRegWB)) 
          begin
            forwardBEX <= 'b01;
          end
        else 
          begin
            forwardBEX <= 'b00;
          end
      end
endmodule

