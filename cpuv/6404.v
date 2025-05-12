module can react 
decreasePrepare <= 1; 
end else begin 
scryptResultAvailable <= 0; 
decreasePrepare <= 0; 
end 
if(pipelineReady & scheduleTask & (workCounter == 3) & ~decreasePrepare & ~doWork) begin 
preparing <= preparing +1; 
end 
if(~(pipelineReady & scheduleTask & (workCounter == 3)) & decreasePrepare & ~doWork) begin 
preparing <= preparing - 1; 
end 
endmodule 