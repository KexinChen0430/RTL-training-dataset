
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
  assign branchstall = (branchID && memToRegMEM && (writeRegMEM == rtID)) || 
                       (regWriteEX && (writeRegEX == rsID) && branchID) || 
                       (
(((writeRegEX == rtID) && branchID && regWriteEX) || 
((writeRegMEM == rsID) || 
(regWriteEX && (writeRegEX == rsID) && branchID))) && (regWriteEX || (branchID && memToRegMEM)) && 
((branchID && memToRegMEM && (writeRegMEM == rtID)) || 
((writeRegEX == rtID) && branchID) || (branchID && memToRegMEM)));
  
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

